pipeline{
    agent {
        label 'node-1'
    }
    stages{
        stage('clone'){
            steps{
                sh """
                      docker image build -t nop:1.0 .
                      docker image tag nop:1.0 tarunkumarpendem/nop:1.0
                      docker image push tarunkumarpendem/nop:1.0
                    """  
            }
        }
    }
}