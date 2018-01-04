#!/usr/bin/env groovy

pipeline {
    agent { label 'linux && docker' }
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 3, unit: 'HOURS')
    }

    stages {
        stage('Test') {
            steps {
                sh 'make check'
            }
        }
        stage('Create builder') {
            steps {
                sh 'make builder'
            }
        }
        stage('Build necessary plugins') {
            when { branch 'master' }
            steps {
                sh 'make plugins'
            }
        }
        stage('Create master container') {
            when { branch 'master' }
            steps {
                sh 'make master'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'build/git-refs.txt', fingerprint: true
                }
            }
        }
    }
    post {
        always {
            sh 'make clean || true'
        }
    }
}
