import 'dotenv/config'

import express from "express";
import {getRandomGif} from "gifs";


const PORT = process.env.PORT || 80;
const MSG = process.env.MSG || "Hello, World!";

const app = express();

app.get('/', (_, res) => {
    res.send(`<h1>${MSG}</h1><div><img src="${getRandomGif()}" /></div>`);
})

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
})