pipeline {
    agent any
    stages {
        stage ('Checkout') {
            steps{
                checkout([$class: 'GitSCM', 
                        branches: [[name: '*/master']], 
                        userRemoteConfigs: [[url: 'https://github.com/prabhatech14/Sudoku-Solver']]])
                        //git branch : 'master', url: 'https://github.com/prabhatech14/Sudoku-Solver' 
            }

        }
        stage ('Build Image') {
            steps {
                script {
                    sh 'pip install -r requirements.txt'
                    sh 'python3 SudokuGUI.py'
                }
            }
        }
    }
}
