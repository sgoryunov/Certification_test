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
        stage ('Waiting for ssh connection') {
            steps {
                sh 'ansible-playbook -i hosts.txt wait_ssh_connection.yml'
            }
        }
        stage ('Build') {
            steps {
                //  play playbook ansible for build
                sh 'ansible-playbook -i hosts.txt --extra-vars "version=$version"  stage_build.yml'
            }
        }
        stage ('Deploy') {
            steps {
                //  copy compose-file and up it for start docker-image 
                sh 'ansible-playbook -i hosts.txt --extra-vars "version=$version" stage_deploy.yml'
            }
        }
    }
}