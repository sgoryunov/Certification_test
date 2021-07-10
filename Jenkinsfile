pipeline {
    agent any
    stages {
        stage ('Create infrastructure') {
            steps {
              sh 'terraform init -input=false'  
              sh 'terraform plan -out=tfplan -input=false'
              sh 'terraform apply -input=false tfplan'
            }
        }
        stage ('build') {
            steps {
                //  play playbook ansible for build
                sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.txt --extra-vars "version=$(version)"  stage_build.yml'
                
            }
        }
        stage ('deploy') {
            steps {
                //  copy compose-file and up it for start docker-image 
                sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.txt --extra-vars "version=$(version)" stage_deploy.yml'
            }
        }
    }
}