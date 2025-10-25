<img width="1914" height="901" alt="Screenshot 2025-10-25 163603" src="https://github.com/user-attachments/assets/745585d2-6971-453f-86d4-98c8a88e473f" />
<img width="1508" height="997" alt="Screenshot 2025-10-25 163727" src="https://github.com/user-attachments/assets/dd01b1eb-f14f-4290-8cf6-3af13022ae5b" />
<img width="1916" height="847" alt="Screenshot 2025-10-25 163815" src="https://github.com/user-attachments/assets/4fb97dec-cd2b-4d8b-a4bc-d31ef2cf2f98" />

# jenkins-CICD
Let’s go step-by-step to create a Declarative Jenkins CI/CD Pipeline that automatically builds, tests, and deploys your code — along with the exact commands


#Prerequisites



    Before starting, make sure you have:

    1 .Jenkins installed and running (http://localhost:8080)

    2 .Git installed and configured

    3 .Docker installed (if you plan to deploy using Docker)

    4 .A GitHub repository containing your project code


Step 1: Create a Jenkinsfile in your project(in jenkins-CICD)
        (In GitHub repo, create a file named Jenkinsfile at the root.)

Step 2: Push to GitHub

        git init
        git add .
        git commit -m "Added Jenkinsfile"
        git branch -M main
        git remote add origin https://github.com/<your-username>/<your-repo>.git
        git push -u origin main


Step 3: Create Jenkins Job
        Open Jenkins Dashboard

         Click “New Item”
         Enter a name (e.g., CICD-Pipeline)
         Select “Pipeline” → Click OK
         Under Pipeline → Definition, select:
         Pipeline script from SCM
         SCM: Git

        Repository URL:
        https://github.com/<your-username>/<your-repo>.git

        Branches to build: */main
        Save the job.


 Step 4:Now click “Build Now” in Jenkins.
        You’ll see stages like:

        Checkout → Build → Test → Deploy

        
Step 5: Verify Logs
        Click on the latest build → Console Output
        You should see:

        Checking out code...
        Building the application...
        Running tests...
        Deploying application...
        Pipeline completed successfully ✅



        

Step 1 : Generate Docker Hub Personal Access Token
Steps:

     1. Go to https://hub.docker.com/
 
     2. Log in to your Docker Hub account

     3. Click your profile picture → Account Settings

     4. Go to Security → Access Tokens

     5. Click “New Access Token”

     6. Enter a name (e.g., jenkins-docker-token)

     7. Select Read, Write, Delete permissions

     8. Click Generate

     Copy the token immediately — you’ll need it in Jenkins.


Step 2: Add Docker Credentials to Jenkins

        1. Open Jenkins Dashboard

        2. Go to Manage Jenkins → Credentials → System → Global credentials (unrestricted)

        3. Click Add Credentials

        4. Select:

             Kind: Username with password

             Username: your Docker Hub username

             Password: your Docker Hub access token

             ID: dockerhub-token

       5. Description: “Docker Hub Token for Jenkins”

       6. Click OK





# Important Note

      🔴 Without adding your Docker Hub token in Jenkins, your pipeline will fail to connect to Docker Hub.
         Jenkins needs authentication to log in and push images — Docker Hub does not allow unauthenticated pushes or logins.
         So this token is mandatory for Jenkins-to-Docker communication.
