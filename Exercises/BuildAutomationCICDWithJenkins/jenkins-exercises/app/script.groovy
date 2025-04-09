def testApp() {
    dir('Exercises/BuildAutomationCICDWithJenkins/jenkins-exercises/app') {
        echo 'Testing application...'
        sh 'npm install'
        sh 'npm test'
    }
}

def buildDockerImage() {
    echo 'Building Docker image...'
    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh "docker build -t ajrusso/devops_bootcamp:${env.VERSION} ."
        sh 'echo $PASS | docker login -u $USER --password-stdin'
        sh "docker push ajrusso/devops_bootcamp:${env.VERSION}"
    }
}

return this