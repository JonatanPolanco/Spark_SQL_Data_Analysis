-- Databricks notebook source
-- MAGIC 
-- MAGIC %run ./Common

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # SETUP
-- MAGIC 
-- MAGIC def setup():
-- MAGIC   return (spark.read
-- MAGIC                .option("inferSchema","true")
-- MAGIC                .option("header","true")
-- MAGIC                .json("/mnt/training/databricks-blog.json")
-- MAGIC                .select("authors", "categories" )
-- MAGIC                .createOrReplaceTempView("databricksBlog")
-- MAGIC )
-- MAGIC 
-- MAGIC setup()
-- MAGIC 
-- MAGIC displayHTML("""
-- MAGIC Declared the following table:
-- MAGIC   <li><span style="color:green; font-weight:bold">databricksBlog</span></li>
-- MAGIC """)