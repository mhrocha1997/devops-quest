from fastapi import FastAPI, HTTPException
from observability import logger

app = FastAPI()

@app.get("/hello")
async def hello():
    logger.info("Hello!")
    return "Hello World!"

@app.get("/error")
async def error():
    logger.warning("Huge error!")
    raise HTTPException(status_code=500, detail="Huge mistake!")

@app.get("/bad-request")
async def bad_request():
    logger.warning("That is some bad request!")
    raise HTTPException(status_code=400, detail="Strange request...")

