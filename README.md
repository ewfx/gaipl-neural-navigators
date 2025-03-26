# 🚀 Project Name : GenAI Integrated Platform Environment

## 📌 Table of Contents
- [Introduction](#introduction)
- [Demo](#demo)
- [Inspiration](#inspiration)
- [What It Does](#what-it-does)
- [How We Built It](#how-we-built-it)
- [Challenges We Faced](#challenges-we-faced)
- [How to Run](#how-to-run)
- [Tech Stack](#tech-stack)
- [Team](#team)

---

## 🎯 Introduction
A web-based or chatbot-powered AI assistant that provides incident resolution suggestions and executes predefined Ansible playbooks to automate troubleshooting. It integrates with Gemini AI to analyze tickets and telemetry data while pulling relevant Knowledge Base articles and related incidents. This automation demonstrates that if we integrate our existing tools like Confluence, ServiceNow, Jira, etc., the system can fetch relevant details as soon as a user enters a query along with server details. It would search across these platforms and provide the necessary information based on our requirements. However, we have not attempted this integration due to the terms and conditions of the Hackathon, which prohibit the use of bank-related tools, APIs, or similar resources


## 🎥 Demo
🔗 [Live Demo](#) (if applicable) : UI - http://13.203.207.238:5173/
📹 [Video Demo](#) (if applicable)  
🖼️ Screenshots: Attached in Artifacts section of repository.

![Screenshot 1](link-to-image)

## 💡 Inspiration
Managing IT incidents manually is time-consuming and error-prone. We aimed to automate troubleshooting by integrating AI-powered analysis with predefined playbooks to suggest and execute fixes.

## ⚙️ What It Does
Accepts incident descriptions from users,
Sends them to Gemini AI for analysis,
Returns a  fix for resolution,
Automates fixes using Ansible Playbooks,
Integrates with ServiceNow, Jira, Confluence (planned)

## 🛠️ How We Built It
Frontend:  React.js for a user-friendly interface,
Backend: FastAPI  for processing incidents,
AI Models: Gemini for analyzing incidents,
Automation: Ansible Playbooks to apply fixes,
Infrastructure: Terraform for AWS deployment

## 🚧 Challenges We Faced
Hackathon Restrictions: We could not integrate real banking APIs
AI Accuracy: Tuning AI models for better recommendations
Infrastructure Setup: Managing AWS resources with Terraform

## 🏃 How to Run
```
Prerequisites
Python 3.8+
Node.js (if using React frontend)
AWS account for cloud deployment
API keys for OpenAI/Gemini

Steps
  Clone the repository
    git clone https://github.com/your-repo-name.git
    cd your-repo-name

Set up Backend
   cd gira-backend
   pip install -r requirements.txt
   python main.py

 Launch Frontend ( React)
   cd gira-frontend
   npx vite    
   
   
Deploy to AWS using Terraform
   cd gira-terraform
   terraform init
   terraform apply
```

## 🏗️ Tech Stack
Frontend: React.js
Backend: FastAPI
AI Models: Gemini
Automation: Ansible Playbooks
Cloud Infrastructure: AWS (EC2, RDS, S3, IAM, CloudWatch, SNS), Terraform

## 👥 Team
 - ** Ujwal** - [GitHub](#) | [LinkedIn](#)
 - ** Shankar** - [GitHub](#) | [LinkedIn](#)
 - ** Punnoose** - kppunnoose2012
 - ** Gaurav** - sharmagd1992 
