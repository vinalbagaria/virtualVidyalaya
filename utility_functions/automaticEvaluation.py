import nltk
import language_check
from gensim.summarization.summarizer import summarize
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize


def summarizeAnswer(text):
    summ_per = summarize(text, ratio=0.6)
    return summ_per

def preprocess(text):
    no_of_words = len(nltk.word_tokenize(text))
    sentences = nltk.sent_tokenize(text)
    no_of_sentences = len(sentences)
    return text,sentences

def cosineSimilarity(text1,text2):
    X = text1.lower()
    Y = text2.lower()
    X_list = word_tokenize(X)
    Y_list = word_tokenize(Y)
    sw = stopwords.words('english')
    l1 = []
    l2 = []
    X_set = {w for w in X_list if not w in sw}
    Y_set = {w for w in Y_list if not w in sw}
    rvector = X_set.union(Y_set)
    for w in rvector:
        if w in X_set:
            l1.append(1)
        else:
            l1.append(0)
        if w in Y_set:
            l2.append(1)
        else:
            l2.append(0)
    c = 0

    # cosine formula
    for i in range(len(rvector)):
        c += l1[i] * l2[i]
    try:
        cosine = c / float((sum(l1) * sum(l2)) ** 0.5)
    except:
        cosine = 1
    print("similarity: ", cosine)
    return cosine

def jaccardSimilarity(text1, text2):
    X = text1.lower()
    Y = text2.lower()
    X_list = word_tokenize(X)
    Y_list = word_tokenize(Y)
    sw = stopwords.words('english')
    l1 = []
    l2 = []
    X_set = {w for w in X_list if not w in sw}
    Y_set = {w for w in Y_list if not w in sw}
    c = X_set.intersection(Y_set)
    return float(len(c)) / (len(X_set) + len(Y_set) - len(c))

def evaluation_model(text1,text2,marks):
    cosineRatio = cosineSimilarity(text1,text2)
    jaccardRatio = jaccardSimilarity(text1,text2)
    knowledge_marks = (0.7*cosineRatio + 0.3*jaccardRatio ) * marks
    return knowledge_marks

def checkGrammar(sentences,grammar_allocated_score):
    tool = language_check.LanguageTool('en-US')
    msgs = ""
    i = 0
    matches = None
    for line in sentences:
        matches = tool.check(line)
        i = i + len(matches)
        for mistake in matches:
            print(type(mistake))
            print(mistake.msg)
            print()
            msgs += mistake.msg + "\n"
        pass
    print("No. of mistakes found in document is ", i)
    print()
    return grammar_allocated_score-i*0.25,msgs

def evaluate(actualAnswer,studentAnswer,type,knowledge_ratio,grammar_ratio,marks):
    if type == 'Descriptive Answer':
        actualAnswer = summarizeAnswer(actualAnswer)
        studentAnswer = summarizeAnswer(studentAnswer)
    actualAnswer,actualSentences = preprocess(actualAnswer)
    studentAnswer,studentSentences = preprocess(studentAnswer)
    grammar_allocated_score = grammar_ratio/100*marks
    knowledge_allocated_score = knowledge_ratio/100*marks

    knowledge_marks = evaluation_model(actualAnswer,studentAnswer,knowledge_allocated_score)
    grammar_marks,msgs = checkGrammar(studentSentences,grammar_allocated_score)
    marksObtained = knowledge_marks + grammar_marks
    return marksObtained,knowledge_marks,grammar_marks,msgs

