def repo_name = (JOB_NAME.tokenize('/') as String[])[0]

pipeline  {
    agent any
    options {
        ansiColor('xterm')
        disableCurrentBuilds()
    }
    stages {
        stage('Init') {
          when {
              expression {return !fileExists('.terraform/plugins')}
          }
          steps {
              sh '''
              set +x
              ARM_ACCESS_KEY
              set -x
              terraform init -force-copy
              '''
          }
        }
        stage('Get') {
            steps {
                sh "terraform get -update"
            }
        }
        stage('Plan') {
            steps {
                sh """
                  set +e
                  set +x
                  export TF_VAR_infoblox_username="xxx"
                  export TF_VAR_infoblox_password="xxx"
                  export ARM_ACCESS_KEY="xxx"
                  export ARM_CLIENT_SECRET="get using cyberArk"

                  echo "==========================================="
                  echo "Running \${BUILD_ID} on something and add more such comments"
                  echo "==========================================="
                  set -x

                  export TF_VAR_build_tag=\${BUILD_TAG}
                  export TF_VAR_build_user=\${BUILD_USER:-unknown.user}

                  # run terraform plan

                  terraform plan -input=false -detailed-exitcode -out output.tfplan
                  TFEXIT=\$?
                  set -e
                  case \$TFEXIT in
                  0)
                      rm output.tfplan
                      exit 0
                      ;;
                  1)
                      rm output.tfplan
                      exit 1
                      ;;
                  2)
                      exit 0
                      ;;
                  *)
                      exit 1
                      ;;
                    esac
                """
            }
        }
        stage('Apply') {
            when {
                  expression { return fileExists('output.tfplan') }
            }
            steps {
                sh """
                    set +e
                    set +x
                    export TF_VAR_infoblox_username="xxx"
                    export TF_VAR_infoblox_password="xxx"
                    export ARM_ACCESS_KEY="xxx"
                    export ARM_CLIENT_SECRET="get using cyberArk"
                    set -x
                    set -e
                    if [[ -f output.tfplan ]]; then terraform apply -input=false output.tfplan && rm output.tfplan; fi
                """
            }
        }
        stage('Confirm recreate') {
            steps {
                timeout(time: 40, unit: 'MINUTES') {
                    input "Proceed to destroy and re-create?"
                }
            }
        }
        stage('Recreate') {
            steps {
                sh """
                    set +e
                    set +x
                    export TF_VAR_infoblox_username="xxx"
                    export TF_VAR_infoblox_password="xxx"
                    export ARM_ACCESS_KEY="xxx"
                    export ARM_CLIENT_SECRET="get using cyberArk"
                    set -x
                    set -e
                    
                    echo ==========================================
                    echo = Terraform output
                    echo ==========================================

                    terraform output -json

                    terraform destroy -input=false -auto-approve

                    terraform apply -input=false -auto-approve

                    terraform output -json > tf_outputs.json

                    cat tf_outputs.json

                """
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}