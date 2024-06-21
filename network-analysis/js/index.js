//Dynamic script on the server side that use the update  
//Link for dns prefetch and make a dns request resolution at real time


const express = require('express');

const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {

  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>DNS Resolution</title>
      <link rel="dns-prefetch">
    </head>
    <body>
      <h1>DNS Resolution</h1>
      <div id="result"></div>

      <script>
        window.onload = function() {
          const domain = window.location.hostname;
          const linkElement = document.querySelector('link[rel="dns-prefetch"]');
          
          if (linkElement) {
            linkElement.href = 'http://' + domain; // Update href if needed

            // Redirect after a short delay (optional)
            setTimeout(() => {
              window.location.href = linkElement.href; 
            }, 10000); // 10000 milliseconds = 10 seconds
          } else {
            console.error('DNS prefetch link element not found.');
          }

          // Perform DNS resolution automatically
          fetch('https://cloudflare-dns.com/dns-query?name=' + domain, {
            headers: {
              'Accept': 'application/dns-json'
            }
          })
          .then(response => response.json())
          .then(data => {
            const addresses = data.Answer.map(answer => answer.data);
            document.getElementById('result').innerHTML = \`
              <h1>DNS Resolution Result</h1>
              <p>Resolved IP addresses for \${domain}:</p>
              <ul>
                \${addresses.map(address => \`<li>\${address}</li>\`).join('')}
              </ul>
            \`;
          })
          .catch(error => {
            console.error('Error resolving DNS:', error);
            document.getElementById('result').innerHTML = 'Error resolving DNS.';
          });
        };
      </script>
    </body>
    </html>
  `);
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});