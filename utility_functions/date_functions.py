from datetime import datetime
def getToday():
    return str(datetime.date())

def getCurDateTime():
    now = datetime.now()
    return now.strftime("%Y-%m-%d %H:%M:%S")