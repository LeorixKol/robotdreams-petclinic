pipeline {
    agent { label 'Master'}
    stages{
        stage('vcs') {
            steps {
                git branch: 'declarative',
                    url: 'https://github.com/Bharatkumar5690/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Test the code by using sonarqube') {
            steps {
                withSonarQubeEnv('SONAR_CLOUD') {
                    sh 'mvn clean verify sonar:sonar -Dsonar.login=ea06c1ce5d1ee81e35db29d8cb0de69b42c70278 -Dsonar.organization=springpetclinic-1'
                }
            }
        }
        stage('Gathering the artifacts & test results') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar',
                                    onlyIfSuccessful: true,
                                    allowEmptyArchive: true
                junit testResults: '**/surefire-reports/TEST-*.xml'
            }
        }
    }
}
