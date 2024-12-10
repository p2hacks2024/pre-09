import { onRequest } from "firebase-functions/v2/https";
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore, doc, getDoc } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries


export const createOgp = onRequest(async (req, res) => {
  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: process.env.APIKEY,
    authDomain: "ebidence-gbc.firebaseapp.com",
    projectId: "ebidence-gbc",
    storageBucket: "ebidence-gbc.firebasestorage.app",
    messagingSenderId: "1083307613485",
    appId: "1:1083307613485:web:1b98cb2658d26ce10f87a4",
    measurementId: "G-G3W84RWD0Z"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const db = getFirestore(app);

  const path = req.path.split("/")[2];
  const docRef = doc(db, "images", path);
  const docSnap = await getDoc(docRef);

  console.log(path);

  if (docSnap.exists()) {
    const data = docSnap.data();
    res.set("Cache-Control", "public, max-age=600, s-maxage=600");
    const html = createHtml(data.url);
    res.status(200).send(html);
  } else {
    res.status(404).send("404 Not Found");
  }
});
const createHtml = (url: string) => {
  return `<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>ebidence</title>
    <meta property="og:title" content="ebidence">
    <meta property="og:description" content="">
    <meta property="og:type" content="article">
    <meta property="og:url" content="https://ebidence-gbc.web.app">
    <meta property="og:site_name" content="ebidence">
    <meta property="og:image" content="${url}">
    <meta name="twitter:site" content="ebidence">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="ebidence">
    <meta name="twitter:description" content="">
    <meta name="twitter:image" content="${url}">
  </head>
  <body>
    <script type="text/javascript">location.href = "https://ebidence-gbc.web.app/#/result";</script>
  </body>
</html>
`;
};
