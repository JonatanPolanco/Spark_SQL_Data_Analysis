-- Databricks notebook source
-- MAGIC 
-- MAGIC %run ./Common

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC 
-- MAGIC spark.conf.set("spark.sql.execution.arrow.pyspark.enabled", "false")
-- MAGIC import pandas as pd
-- MAGIC from pyspark.sql.functions import *
-- MAGIC from pyspark.sql.types import *
-- MAGIC 
-- MAGIC jsonString = """
-- MAGIC [{
-- MAGIC   "id": 1,
-- MAGIC   "firstName": "Lance",
-- MAGIC   "lastName": "Da Costa",
-- MAGIC   "expenses": [
-- MAGIC     {
-- MAGIC       "cardType": "jcb",
-- MAGIC       "charges": "2222.46",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-18",
-- MAGIC       "paymentDue": "2020-07-18"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "jcb",
-- MAGIC       "charges": "5976.76",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-01",
-- MAGIC       "paymentDue": "2020-07-22"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "visa",
-- MAGIC       "charges": "2543.55",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-12",
-- MAGIC       "paymentDue": "2020-07-22"
-- MAGIC     }
-- MAGIC   ]
-- MAGIC }, {
-- MAGIC   "id": 2,
-- MAGIC   "firstName": "Emilie",
-- MAGIC   "lastName": "Newlove",
-- MAGIC   "expenses": [
-- MAGIC     {
-- MAGIC       "cardType": "bankcard",
-- MAGIC       "charges": "6344.33",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-10",
-- MAGIC       "paymentDue": "2020-07-08"
-- MAGIC     }
-- MAGIC   ]
-- MAGIC }, {
-- MAGIC   "id": 3,
-- MAGIC   "firstName": "Alvy",
-- MAGIC   "lastName": "Records",
-- MAGIC   "expenses": [
-- MAGIC     {
-- MAGIC       "cardType": "mastercard",
-- MAGIC       "charges": "9170.83",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-02",
-- MAGIC       "paymentDue": "2020-07-29"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "maestro",
-- MAGIC       "charges": "3201.67",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-06",
-- MAGIC       "paymentDue": "2020-07-22"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "americanexpress",
-- MAGIC       "charges": "6087.61",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-28",
-- MAGIC       "paymentDue": "2020-07-08"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "americanexpress",
-- MAGIC       "charges": "3392.61",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-12",
-- MAGIC       "paymentDue": "2020-07-21"
-- MAGIC     }
-- MAGIC   ]
-- MAGIC }, {
-- MAGIC   "id": 4,
-- MAGIC   "firstName": "Jena",
-- MAGIC   "lastName": "Fairley",
-- MAGIC   "expenses": [
-- MAGIC     {
-- MAGIC       "cardType": "jcb",
-- MAGIC       "charges": "9726.16",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-25",
-- MAGIC       "paymentDue": "2020-07-17"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "americanexpress",
-- MAGIC       "charges": "2578.18",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-27",
-- MAGIC       "paymentDue": "2020-07-14"
-- MAGIC     }
-- MAGIC   ]
-- MAGIC }, {
-- MAGIC   "id": 5,
-- MAGIC   "firstName": "Klarika",
-- MAGIC   "lastName": "Pady",
-- MAGIC   "expenses": [
-- MAGIC     {
-- MAGIC       "cardType": "bankcard",
-- MAGIC       "charges": "8460.46",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-12",
-- MAGIC       "paymentDue": "2020-07-17"
-- MAGIC     },
-- MAGIC     {
-- MAGIC       "cardType": "bankcard",
-- MAGIC       "charges": "8573.72",
-- MAGIC       "currency": "USD",
-- MAGIC       "lastPayment": "2020-07-11",
-- MAGIC       "paymentDue": "2020-07-08"
-- MAGIC     }
-- MAGIC   ]
-- MAGIC }]
-- MAGIC """
-- MAGIC 
-- MAGIC pandasDF = pd.read_json(jsonString)
-- MAGIC dataDF = spark.createDataFrame(pandasDF)
-- MAGIC dataDF.createOrReplaceTempView("finances")
-- MAGIC 
-- MAGIC displayHTML("""
-- MAGIC Declared the following table:
-- MAGIC   <li><span style="color:green; font-weight:bold">finances</span></li>
-- MAGIC """)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC 
-- MAGIC sqlContext.sql("""CREATE OR REPLACE TEMPORARY VIEW charges AS
-- MAGIC   SELECT id, firstName, lastName, 
-- MAGIC   TRANSFORM (expenses, card -> card.charges) AS allCharges
-- MAGIC   FROM finances""")
-- MAGIC 
-- MAGIC displayHTML("""
-- MAGIC Declared the following table:
-- MAGIC   <li><span style="color:green; font-weight:bold">charges</span></li>
-- MAGIC """)