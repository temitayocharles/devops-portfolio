#!/bin/bash

# Step 1: Create structure
mkdir -p devops-portfolio/{projects,assets/{diagrams,logos,profile},styles,.github/workflows}

# Step 2: Download assets
curl -sL https://raw.githubusercontent.com/gilbarbara/logos/main/logos/aws.svg -o devops-portfolio/assets/logos/aws.svg
curl -sL https://raw.githubusercontent.com/gilbarbara/logos/main/logos/kubernetes.svg -o devops-portfolio/assets/logos/k8s.svg
curl -sL https://raw.githubusercontent.com/cloudacademy/amazon-rds-architecture/main/images/rds-architecture.png -o devops-portfolio/assets/diagrams/rds-arch.png
curl -sL https://raw.githubusercontent.com/identicons/github/main/avatars/default.png -o devops-portfolio/assets/profile/profile.png

# Step 3: Global CSS
cat > devops-portfolio/styles/style.css <<EOF
body {
  font-family: 'Segoe UI', sans-serif;
  background: #0f172a;
  color: #e2e8f0;
  margin: 0; padding: 0;
}
main {
  max-width: 900px;
  margin: auto;
  background: #1e293b;
  padding: 40px;
  border-radius: 12px;
  animation: fadeIn 1s ease-in;
}
nav {
  background: #1e293b;
  padding: 1em;
  text-align: center;
}
nav a {
  color: #7dd3fc;
  margin: 0 15px;
  text-decoration: none;
  font-weight: bold;
}
nav a:hover { text-decoration: underline; }
footer {
  text-align: center;
  padding: 2em 1em;
  color: #64748b;
  font-size: 0.8em;
}
.logo-bar {
  text-align: center;
  padding: 10px;
}
.logo-bar img {
  height: 40px;
  margin: 0 10px;
  animation: float 3s infinite ease-in-out;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-5px); }
}
EOF

# Step 4: GitHub Pages CNAME
echo "www.meetcharlie.live" > devops-portfolio/CNAME

# Step 5: Contact page
cat > devops-portfolio/contact.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Charles</title>
  <link rel="stylesheet" href="styles/style.css">
</head>
<body>
  <nav><a href="/">Home</a> <a href="/contact.html">Contact</a></nav>
  <main>
    <h1>Contact Charles</h1>
    <form action="mailto:s9charles.wft@gmail.com" method="post" enctype="text/plain">
      <label>Name:<br><input type="text" name="name" required></label><br><br>
      <label>Email:<br><input type="email" name="email" required></label><br><br>
      <label>Message:<br><textarea name="message" rows="6" required></textarea></label><br><br>
      <button type="submit">Send</button>
    </form>
  </main>
  <div class="logo-bar">
    <img src="assets/logos/aws.svg" alt="AWS" />
    <img src="assets/logos/k8s.svg" alt="Kubernetes" />
  </div>
  <footer>&copy; 2025 Charles | Built with GitHub Pages & Markdown</footer>
</body>
</html>
EOF

# Step 6: GitHub Actions deployment workflow
cat > devops-portfolio/.github/workflows/pages.yml <<EOF
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Deploy
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: \${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./devops-portfolio
EOF

echo "✅ Portfolio setup complete. Paste HTML projects into devops-portfolio/projects/ and push to main."
