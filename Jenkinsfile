pipeline {
    agent any

    stages {
        stage('Deploy Blue Environment') {
            steps {
                sh 'docker-compose -f docker-compose-blue.yml up -d'
                // Add any validations or tests for the blue environment
            }
        }

        stage('Deploy Green Environment') {
            steps {
                sh 'docker-compose -f docker-compose-green.yml up -d'
                // Check Prometheus metrics for the green environment
                sh 'curl http://localhost:9292/api/v1/query?query=up{job="app"}' | grep 1

// If Prometheus metrics are healthy, proceed to switch traffic
                // Add tests or validations for the green environment
                // If successful, proceed to switch traffic
            }
        }

        stage('Switch Traffic') {
            steps {
                script {
                    // Update DNS or load balancer configuration to switch traffic to the green environment
                    sh 'sudo nginx -s reload'

// Validate that traffic is now routed to the green environment
                    curl http://localhost:8080/healthz | grep OK
                    sh "docker-compose -f docker-compose.yml down" // Shut down both blue and green
                    sh "mv docker-compose-green.yml docker-compose.yml" // Rename green to default compose file
                    sh 'docker-compose up -d' // Start the green environment
                    // Implement logic to switch traffic from blue to green (DNS update, load balancer configurations, etc.)
                    // Ensure proper validation before switching traffic
                }
            }
        }
    }
}
