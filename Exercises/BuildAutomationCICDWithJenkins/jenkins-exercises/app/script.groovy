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
        dir('Exercises/BuildAutomationCICDWithJenkins/jenkins-exercises/app') {
            sh "docker build -t ajrusso/devops_bootcamp:${env.VERSION} ."
            sh 'echo $PASS | docker login -u $USER --password-stdin'
            sh "docker push ajrusso/devops_bootcamp:${env.VERSION}"
        }
    }
}

def commitVersion() {
    echo 'Commiting and pushing updated version to Git...'
    withCredentials([usernamePassword(credentialsId: 'github-token', passwordVariable: 'TOKEN', usernameVariable: 'USER')]) {
        sh 'git config --global user.email "jenkins@example.com"'
        sh 'git config --global user.name "jenkins"'
        sh "git checkout ${env.BRANCH_NAME}"
        sh 'git status'
        sh 'git branch'
        sh 'git config --list'
        sh "git remote set-url origin https://\$USER:\$TOKEN@github.com/ajrusso/DevOpsBootcamp.git"
        sh 'git add .'
        sh 'git commit -m "ci: versionbump"'
        sh "git push origin ${env.BRANCH_NAME}"
    }
}

return this