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
        stage ('Build') {
            steps {
                //  play playbook ansible for build
                // sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.txt --extra-vars "version=$(version)"  stage_build.yml'
                ansiblePlaybook extras: 'version=$version', inventory: 'hosts.txt', playbook: 'stage_build.yml', sudoUser: 'ubuntu' 
            }
        }
        stage ('Deploy') {
            steps {
                //  copy compose-file and up it for start docker-image 
                // sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.txt --extra-vars "version=$(version)" stage_deploy.yml'
                ansiblePlaybook extras: 'version=$version', inventory: 'hosts.txt', playbook: 'stage_deploy.yml', sudoUser: 'ubuntu'
            }
        }
    }
}