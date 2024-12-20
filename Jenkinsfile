pipeline {
    agent any

    environment {
        DEFECT_DOJO_API_URL = 'http://nginx:8080/api/v2'
    }

    stages {
        stage('clone') {
            steps {
                echo 'Clonando projeto a ser analisado VAmPI'
                
                dir('project/VAmPI') {
                    git(url: 'https://github.com/erev0s/VAmPI')
                }
            }
        }
        
        stage('SAST') {
            steps {
                echo 'Executando análise SAST utilizando bandit'
                
                dir('project') {
                    // || true para continuar a execução, pois o bandit retorna 1
                    // devido aos erros que o projeto VAmPI possui
                    sh 'bandit -r VAmPI -f json -o bandit_report.json || true'
                }
            }
        }

        stage('SCA') {
            steps {
                echo 'Executando análise SCA utilizando trivy'

                dir('project') {
                    sh 'trivy fs VAmPI --scanners vuln,misconfig,license  -f json -o trivy_report.json';
                }
            }
        }

        stage('Secrets') {
            steps {
                echo 'Executando análise de Secrets utilizando GitLeaks'

                dir('project') {
                    // || true para continuar a execução, pois o gitleaks retorna 1
                    // devido aos erros que o projeto VAmPI possui
                    sh 'gitleaks dir VAmPI/ -f json -r gitleaks_report.json || true'
                }
            }
        }

        stage('DefectDojo') {
            steps{
                dir('project') {
                    
                    withCredentials([string(credentialsId: 'DEFECT_DOJO_API_KEY', variable: 'API_KEY')]) {
                        echo 'Realizando upload do relatório Bandit...'
                        sh '''
                            curl -X 'POST' \
                            "$DEFECT_DOJO_API_URL/import-scan/" \
                            -H 'accept: application/json' \
                            -H 'Content-Type: multipart/form-data' \
                            -H "Authorization: Token $API_KEY" \
                            -F 'product_name=VAmPI' \
                            -F 'engagement_name=Jenkins' \
                            -F 'deduplication_on_engagement=true' \
                            -F "scan_date=$(date +'%Y-%m-%d')" \
                            -F 'file=@bandit_report.json;type=application/json' \
                            -F 'scan_type=Bandit Scan' \
                            -F 'branch_tag=master' \
                            -F 'source_code_management_uri=https://github.com/erev0s/VAmPI' \
                        '''

                        echo 'Realizando upload do relatório Trivy...'
                        sh '''
                            curl -X 'POST' \
                            "$DEFECT_DOJO_API_URL/import-scan/" \
                            -H 'accept: application/json' \
                            -H 'Content-Type: multipart/form-data' \
                            -H "Authorization: Token $API_KEY" \
                            -F 'product_name=VAmPI' \
                            -F 'engagement_name=Jenkins' \
                            -F 'deduplication_on_engagement=true' \
                            -F "scan_date=$(date +'%Y-%m-%d')" \
                            -F 'file=@trivy_report.json;type=application/json' \
                            -F 'scan_type=Trivy Scan' \
                            -F 'branch_tag=master' \
                            -F 'source_code_management_uri=https://github.com/erev0s/VAmPI' \
                        '''

                        echo 'Realizando upload do relatório GitLeaks...'
                        sh '''
                            curl -X 'POST' \
                            "$DEFECT_DOJO_API_URL/import-scan/" \
                            -H 'accept: application/json' \
                            -H 'Content-Type: multipart/form-data' \
                            -H "Authorization: Token $API_KEY" \
                            -F 'product_name=VAmPI' \
                            -F 'engagement_name=Jenkins' \
                            -F 'deduplication_on_engagement=true' \
                            -F "scan_date=$(date +'%Y-%m-%d')" \
                            -F 'file=@gitleaks_report.json;type=application/json' \
                            -F 'scan_type=Gitleaks Scan' \
                            -F 'branch_tag=master' \
                            -F 'source_code_management_uri=https://github.com/erev0s/VAmPI' \
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Limpando diretório \'project\''
            sh 'rm -rf project'
        }
    }
}
