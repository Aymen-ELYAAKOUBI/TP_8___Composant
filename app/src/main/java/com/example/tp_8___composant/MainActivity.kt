package com.example.tp_8___composant

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.Button
import android.widget.ProgressBar
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : AppCompatActivity() {

    private lateinit var tvStatus: TextView
    private lateinit var progressBar: ProgressBar
    private lateinit var btnThreadHandler: Button
    private lateinit var btnCoroutine: Button
    private lateinit var btnHeavyTask: Button

    private val mainHandler = Handler(Looper.getMainLooper())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        tvStatus = findViewById(R.id.tvStatus)
        progressBar = findViewById(R.id.progressBar)
        btnThreadHandler = findViewById(R.id.btnThreadHandler)
        btnCoroutine = findViewById(R.id.btnCoroutine)
        btnHeavyTask = findViewById(R.id.btnHeavyTask)

        btnThreadHandler.setOnClickListener {
            runTaskWithThreadAndHandler()
        }

        btnCoroutine.setOnClickListener {
            runTaskWithCoroutines()
        }

        btnHeavyTask.setOnClickListener {
            runHeavyTask()
        }
    }

    private fun runTaskWithThreadAndHandler() {
        btnThreadHandler.isEnabled = false
        tvStatus.text = "Tâche Thread + Handler en cours..."
        progressBar.progress = 0

        Thread {
            for (i in 1..10) {
                Thread.sleep(300)
                val progress = i * 10
                mainHandler.post {
                    progressBar.progress = progress
                    tvStatus.text = "Progression (Thread) : $progress%"
                }
            }

            mainHandler.post {
                tvStatus.text = "Tâche Thread + Handler terminée !"
                btnThreadHandler.isEnabled = true
            }
        }.start()
    }

    private fun runTaskWithCoroutines() {
        btnCoroutine.isEnabled = false
        tvStatus.text = "Tâche Coroutines en cours..."
        progressBar.progress = 0

        lifecycleScope.launch {
            withContext(Dispatchers.IO) {
                for (i in 1..10) {
                    delay(300)
                    val progress = i * 10
                    withContext(Dispatchers.Main) {
                        progressBar.progress = progress
                        tvStatus.text = "Progression (Coroutine) : $progress%"
                    }
                }
            }
            tvStatus.text = "Tâche Coroutines terminée !"
            btnCoroutine.isEnabled = true
        }
    }

    private fun runHeavyTask() {
        btnHeavyTask.isEnabled = false
        tvStatus.text = "Calcul lourd en arrière-plan..."
        progressBar.isIndeterminate = true

        lifecycleScope.launch {
            val result = withContext(Dispatchers.IO) {
                // Simulation d'un calcul lourd
                var sum = 0L
                for (i in 1..1_000_000_000L) {
                    sum += i % 7
                }
                sum
            }

            progressBar.isIndeterminate = false
            progressBar.progress = 100
            tvStatus.text = "Calcul terminé ! Résultat: $result"
            btnHeavyTask.isEnabled = true
        }
    }
}