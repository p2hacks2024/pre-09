"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createOgp = void 0;
const https_1 = require("firebase-functions/v2/https");
// Import the functions you need from the SDKs you need
const app_1 = require("firebase/app");
const firestore_1 = require("firebase/firestore");
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
exports.createOgp = (0, https_1.onRequest)(async (req, res) => {
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
    const app = (0, app_1.initializeApp)(firebaseConfig);
    const db = (0, firestore_1.getFirestore)(app);
    const path = req.path.split("/")[2];
    const docRef = (0, firestore_1.doc)(db, "images", path);
    const docSnap = await (0, firestore_1.getDoc)(docRef);
    console.log(path);
    if (docSnap.exists()) {
        const data = docSnap.data();
        const imageUrl = data.url; // Firestoreに保存された画像URL
        const docId = path; // URLから取得したドキュメントID
        res.set("Cache-Control", "public, max-age=600, s-maxage=600");
        const html = createHtml(docId, imageUrl);
        res.status(200).send(html);
    }
    else {
        res.status(404).send("404 Not Found");
    }
});
const createHtml = (docId, imageUrl) => {
    return `<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>ebidence</title>
    <meta property="og:title" content="ebidence">
    <meta property="og:description" content="">
    <meta property="og:type" content="article">
    <meta property="og:url" content="https://ebidence-gbc.web.app/result/${docId}">
    <meta property="og:site_name" content="ebidence">
    <meta property="og:image" content="${imageUrl}">
    <meta name="twitter:site" content="ebidence">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="ebidence">
    <meta name="twitter:description" content="ebidence">
    <meta name="twitter:image" content="${imageUrl}">
  </head>
  <body>
    <script type="text/javascript">location.href = "https://ebidence-gbc.web.app/#/result/${docId}";</script>
  </body>
</html>
`;
};
//# sourceMappingURL=index.js.map