require('dotenv').config()

import express from 'express';
import errorHandler from 'errorhandler';
import { json, urlencoded } from 'body-parser';
import methodOverride from 'method-override';
import logger from 'morgan';

const app = express()
const port = 3000 || process.env.PORT

app.use(logger('dev'))
app.use(json())
app.use(urlencoded({ extended: false }))
app.use(methodOverride('_method'))
app.use(errorHandler())

app.use((req, res, next) => {
})

app.get('/', async (req, res) => {

  })

app.get('/*/:uid', async (req, res) => {
  
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
