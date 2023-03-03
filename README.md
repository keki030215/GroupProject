# GroupProject


## Link to our dataset topic:
https://www.kaggle.com/datasets/uciml/student-alcohol-consumption

## Data and Audience
## Depending on the specifics of your project, you should outline the answers to these (and perhaps other) questions:

## What is the dataset you’ll be working with? Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.
## The data were obtained in a survey of students' math and Portuguese language courses in secondary school. It contains a lot of interesting social, gender and study information about students. You can use it for some EDA or try to predict students' final grade. We accessed the data through Kaggle.com.

## Who is your target audience? Depending on the domain of your data, there may be a variety of audiences interested in using the dataset. You should home in on one of these audiences.
## Our targeted audience is going to be people who are interested in research on students between  elementary school and college about their alcohol assumption. 
What does your audience want to learn from your data? Please list out at least 3 specific questions that your project will answer for your audience. (Liuhan)
1. How alcohol consumption would affect academic performances. (especially Portuguese language course)
2. If there is a relationship between alcohol consumption and parents’ cohabitation status.
3. Whether the workdays alcohol consumption and weekends alcohol consumption would have different effects.
Technical Description
This section of your proposal asks you to think through the specific analytical steps you’ll need to complete throughout the project.
How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?
We used a  static .csv file gathered from kaggle, the data is a spreadsheet with 33 variables and 395 participants. We use read.csv to read in the data.
What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?
We need to reformat data and find the potential relationships between variables,  which variables related to higher weekend alcohol consumption and worse current health status.  We can extract the data of high alcohol consumption members and analyze the factors of them, such as gender, family’s education level, family size and address etc. 
What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr) (Liuhan)
{esquisse}
What questions, if any, will you be answering with statistical analysis/machine learning? 
Questions we will be answering with our statistical analysis/machine learning will include:
How does the data support our specific project questions?
What are the interpretations of the graphs within our data?
What major challenges do you anticipate? 
Major challenges we will anticipate is analyzing our dataset which we will be working with. Specifically, coding and manipulating the data to help answer our project questions. However, we strongly believe that if we communicate and work together, we will be able to exceptionally analyze our dataset .

