{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "38fedf80",
   "metadata": {
    "papermill": {
     "duration": 0.006808,
     "end_time": "2022-12-11T21:11:52.796449",
     "exception": false,
     "start_time": "2022-12-11T21:11:52.789641",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Titanic Machine Learning model\n",
    "This is a model to predict the survival of a passenger from different variables such as name, gender,class,age and ticket of passenger.\n",
    "This model is created to determine while testing for factors that contribute the most to the determination of survival of passengers.\n",
    "\n",
    "## The outline of Process\n",
    "The model creation, testing and validation process is outlined in the following way;\n",
    "\n",
    "* Importating libraries and dataset\n",
    "* Dataset exploration and clean up\n",
    "* Dataset split and train and test data split\n",
    "* Model creation and model implementation\n",
    "* Model accuracy test"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "0cc0d04c",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:11:52.812523Z",
     "iopub.status.busy": "2022-12-11T21:11:52.809748Z",
     "iopub.status.idle": "2022-12-11T21:12:22.922276Z",
     "shell.execute_reply": "2022-12-11T21:12:22.920383Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 30.123776,
     "end_time": "2022-12-11T21:12:22.925595",
     "exception": false,
     "start_time": "2022-12-11T21:11:52.801819",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n",
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n",
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.2 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.6      \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.5 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.8      \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.10\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.1      \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.1 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.3      \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.2 \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n"
     ]
    }
   ],
   "source": [
    "#Importation of library\n",
    "install.packages(\"caTools\")\n",
    "install.packages(\"tidyverse\")\n",
    "library(tidyverse)\n",
    "library(dplyr)\n",
    "library(tidyr)\n",
    "library(ggplot2)\n",
    "library(caTools)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1d9b36bc",
   "metadata": {
    "papermill": {
     "duration": 0.005896,
     "end_time": "2022-12-11T21:12:22.937308",
     "exception": false,
     "start_time": "2022-12-11T21:12:22.931412",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "After importing our libraries,we go ahead to bring in our dataset, and carry on with our data exploration on our training dataset"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "38e93158",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:22.982441Z",
     "iopub.status.busy": "2022-12-11T21:12:22.950518Z",
     "iopub.status.idle": "2022-12-11T21:12:23.120942Z",
     "shell.execute_reply": "2022-12-11T21:12:23.119165Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.18025,
     "end_time": "2022-12-11T21:12:23.123328",
     "exception": false,
     "start_time": "2022-12-11T21:12:22.943078",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Survived</th><th scope=col>Pclass</th><th scope=col>Name</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Cabin</th><th scope=col>Embarked</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1</td><td>0</td><td>3</td><td>Braund, Mr. Owen Harris                            </td><td>male  </td><td>22</td><td>1</td><td>0</td><td>A/5 21171       </td><td> 7.2500</td><td>    </td><td>S</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2</td><td>1</td><td>1</td><td>Cumings, Mrs. John Bradley (Florence Briggs Thayer)</td><td>female</td><td>38</td><td>1</td><td>0</td><td>PC 17599        </td><td>71.2833</td><td>C85 </td><td>C</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>1</td><td>3</td><td>Heikkinen, Miss. Laina                             </td><td>female</td><td>26</td><td>0</td><td>0</td><td>STON/O2. 3101282</td><td> 7.9250</td><td>    </td><td>S</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4</td><td>1</td><td>1</td><td>Futrelle, Mrs. Jacques Heath (Lily May Peel)       </td><td>female</td><td>35</td><td>1</td><td>0</td><td>113803          </td><td>53.1000</td><td>C123</td><td>S</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>5</td><td>0</td><td>3</td><td>Allen, Mr. William Henry                           </td><td>male  </td><td>35</td><td>0</td><td>0</td><td>373450          </td><td> 8.0500</td><td>    </td><td>S</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>6</td><td>0</td><td>3</td><td>Moran, Mr. James                                   </td><td>male  </td><td>NA</td><td>0</td><td>0</td><td>330877          </td><td> 8.4583</td><td>    </td><td>Q</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & PassengerId & Survived & Pclass & Name & Sex & Age & SibSp & Parch & Ticket & Fare & Cabin & Embarked\\\\\n",
       "  & <int> & <int> & <int> & <chr> & <chr> & <dbl> & <int> & <int> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1 & 0 & 3 & Braund, Mr. Owen Harris                             & male   & 22 & 1 & 0 & A/5 21171        &  7.2500 &      & S\\\\\n",
       "\t2 & 2 & 1 & 1 & Cumings, Mrs. John Bradley (Florence Briggs Thayer) & female & 38 & 1 & 0 & PC 17599         & 71.2833 & C85  & C\\\\\n",
       "\t3 & 3 & 1 & 3 & Heikkinen, Miss. Laina                              & female & 26 & 0 & 0 & STON/O2. 3101282 &  7.9250 &      & S\\\\\n",
       "\t4 & 4 & 1 & 1 & Futrelle, Mrs. Jacques Heath (Lily May Peel)        & female & 35 & 1 & 0 & 113803           & 53.1000 & C123 & S\\\\\n",
       "\t5 & 5 & 0 & 3 & Allen, Mr. William Henry                            & male   & 35 & 0 & 0 & 373450           &  8.0500 &      & S\\\\\n",
       "\t6 & 6 & 0 & 3 & Moran, Mr. James                                    & male   & NA & 0 & 0 & 330877           &  8.4583 &      & Q\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Survived &lt;int&gt; | Pclass &lt;int&gt; | Name &lt;chr&gt; | Sex &lt;chr&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Cabin &lt;chr&gt; | Embarked &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1 | 0 | 3 | Braund, Mr. Owen Harris                             | male   | 22 | 1 | 0 | A/5 21171        |  7.2500 | <!----> | S |\n",
       "| 2 | 2 | 1 | 1 | Cumings, Mrs. John Bradley (Florence Briggs Thayer) | female | 38 | 1 | 0 | PC 17599         | 71.2833 | C85  | C |\n",
       "| 3 | 3 | 1 | 3 | Heikkinen, Miss. Laina                              | female | 26 | 0 | 0 | STON/O2. 3101282 |  7.9250 | <!----> | S |\n",
       "| 4 | 4 | 1 | 1 | Futrelle, Mrs. Jacques Heath (Lily May Peel)        | female | 35 | 1 | 0 | 113803           | 53.1000 | C123 | S |\n",
       "| 5 | 5 | 0 | 3 | Allen, Mr. William Henry                            | male   | 35 | 0 | 0 | 373450           |  8.0500 | <!----> | S |\n",
       "| 6 | 6 | 0 | 3 | Moran, Mr. James                                    | male   | NA | 0 | 0 | 330877           |  8.4583 | <!----> | Q |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Survived Pclass\n",
       "1 1           0        3     \n",
       "2 2           1        1     \n",
       "3 3           1        3     \n",
       "4 4           1        1     \n",
       "5 5           0        3     \n",
       "6 6           0        3     \n",
       "  Name                                                Sex    Age SibSp Parch\n",
       "1 Braund, Mr. Owen Harris                             male   22  1     0    \n",
       "2 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female 38  1     0    \n",
       "3 Heikkinen, Miss. Laina                              female 26  0     0    \n",
       "4 Futrelle, Mrs. Jacques Heath (Lily May Peel)        female 35  1     0    \n",
       "5 Allen, Mr. William Henry                            male   35  0     0    \n",
       "6 Moran, Mr. James                                    male   NA  0     0    \n",
       "  Ticket           Fare    Cabin Embarked\n",
       "1 A/5 21171         7.2500       S       \n",
       "2 PC 17599         71.2833 C85   C       \n",
       "3 STON/O2. 3101282  7.9250       S       \n",
       "4 113803           53.1000 C123  S       \n",
       "5 373450            8.0500       S       \n",
       "6 330877            8.4583       Q       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "  PassengerId       Survived          Pclass          Name          \n",
       " Min.   :  1.0   Min.   :0.0000   Min.   :1.000   Length:891        \n",
       " 1st Qu.:223.5   1st Qu.:0.0000   1st Qu.:2.000   Class :character  \n",
       " Median :446.0   Median :0.0000   Median :3.000   Mode  :character  \n",
       " Mean   :446.0   Mean   :0.3838   Mean   :2.309                     \n",
       " 3rd Qu.:668.5   3rd Qu.:1.0000   3rd Qu.:3.000                     \n",
       " Max.   :891.0   Max.   :1.0000   Max.   :3.000                     \n",
       "                                                                    \n",
       "     Sex                 Age            SibSp           Parch       \n",
       " Length:891         Min.   : 0.42   Min.   :0.000   Min.   :0.0000  \n",
       " Class :character   1st Qu.:20.12   1st Qu.:0.000   1st Qu.:0.0000  \n",
       " Mode  :character   Median :28.00   Median :0.000   Median :0.0000  \n",
       "                    Mean   :29.70   Mean   :0.523   Mean   :0.3816  \n",
       "                    3rd Qu.:38.00   3rd Qu.:1.000   3rd Qu.:0.0000  \n",
       "                    Max.   :80.00   Max.   :8.000   Max.   :6.0000  \n",
       "                    NA's   :177                                     \n",
       "    Ticket               Fare           Cabin             Embarked        \n",
       " Length:891         Min.   :  0.00   Length:891         Length:891        \n",
       " Class :character   1st Qu.:  7.91   Class :character   Class :character  \n",
       " Mode  :character   Median : 14.45   Mode  :character   Mode  :character  \n",
       "                    Mean   : 32.20                                        \n",
       "                    3rd Qu.: 31.00                                        \n",
       "                    Max.   :512.33                                        \n",
       "                                                                          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "177"
      ],
      "text/latex": [
       "177"
      ],
      "text/markdown": [
       "177"
      ],
      "text/plain": [
       "[1] 177"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "    Survived          Pclass          Sex                 Age       \n",
       " Min.   :0.0000   Min.   :1.000   Length:714         Min.   : 0.42  \n",
       " 1st Qu.:0.0000   1st Qu.:1.000   Class :character   1st Qu.:20.12  \n",
       " Median :0.0000   Median :2.000   Mode  :character   Median :28.00  \n",
       " Mean   :0.4062   Mean   :2.237                      Mean   :29.70  \n",
       " 3rd Qu.:1.0000   3rd Qu.:3.000                      3rd Qu.:38.00  \n",
       " Max.   :1.0000   Max.   :3.000                      Max.   :80.00  \n",
       "     SibSp            Parch           Ticket               Fare       \n",
       " Min.   :0.0000   Min.   :0.0000   Length:714         Min.   :  0.00  \n",
       " 1st Qu.:0.0000   1st Qu.:0.0000   Class :character   1st Qu.:  8.05  \n",
       " Median :0.0000   Median :0.0000   Mode  :character   Median : 15.74  \n",
       " Mean   :0.5126   Mean   :0.4314                      Mean   : 34.69  \n",
       " 3rd Qu.:1.0000   3rd Qu.:1.0000                      3rd Qu.: 33.38  \n",
       " Max.   :5.0000   Max.   :6.0000                      Max.   :512.33  \n",
       "   Embarked        \n",
       " Length:714        \n",
       " Class :character  \n",
       " Mode  :character  \n",
       "                   \n",
       "                   \n",
       "                   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I go ahead to import my train dataset and do basic exploration\n",
    "#I also carry out test cleaning just in case\n",
    "train_dataset <- read.csv(\"/kaggle/input/titanic/train.csv\")\n",
    "head(train_dataset)\n",
    "summary(train_dataset)\n",
    "sum(is.na(train_dataset))\n",
    "\n",
    "#From above,I did notice there are NA values in the dataset \n",
    "#With the help of the summary function,I noticed the age varible to be\n",
    "#the one containing NA values.\n",
    "train_no_na <- train_dataset %>% select(-1,-4 ,-11) %>%\n",
    "                      drop_na()\n",
    "#Proceeding to check the summary of my new data without NA values.\n",
    "summary(train_no_na)\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "95f7fa63",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:23.139586Z",
     "iopub.status.busy": "2022-12-11T21:12:23.138026Z",
     "iopub.status.idle": "2022-12-11T21:12:23.178394Z",
     "shell.execute_reply": "2022-12-11T21:12:23.176115Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.051645,
     "end_time": "2022-12-11T21:12:23.181436",
     "exception": false,
     "start_time": "2022-12-11T21:12:23.129791",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Survived</th><th scope=col>Pclass</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Embarked</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>3</td><td>1</td><td>22</td><td>1</td><td>0</td><td>A/5 21171       </td><td> 7.2500</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1</td><td>1</td><td>0</td><td>38</td><td>1</td><td>0</td><td>PC 17599        </td><td>71.2833</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>3</td><td>0</td><td>26</td><td>0</td><td>0</td><td>STON/O2. 3101282</td><td> 7.9250</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1</td><td>1</td><td>0</td><td>35</td><td>1</td><td>0</td><td>113803          </td><td>53.1000</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0</td><td>3</td><td>1</td><td>35</td><td>0</td><td>0</td><td>373450          </td><td> 8.0500</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>1</td><td>1</td><td>54</td><td>0</td><td>0</td><td>17463           </td><td>51.8625</td><td>2</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 9\n",
       "\\begin{tabular}{r|lllllllll}\n",
       "  & Survived & Pclass & Sex & Age & SibSp & Parch & Ticket & Fare & Embarked\\\\\n",
       "  & <fct> & <fct> & <fct> & <dbl> & <int> & <int> & <chr> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 3 & 1 & 22 & 1 & 0 & A/5 21171        &  7.2500 & 2\\\\\n",
       "\t2 & 1 & 1 & 0 & 38 & 1 & 0 & PC 17599         & 71.2833 & 0\\\\\n",
       "\t3 & 1 & 3 & 0 & 26 & 0 & 0 & STON/O2. 3101282 &  7.9250 & 2\\\\\n",
       "\t4 & 1 & 1 & 0 & 35 & 1 & 0 & 113803           & 53.1000 & 2\\\\\n",
       "\t5 & 0 & 3 & 1 & 35 & 0 & 0 & 373450           &  8.0500 & 2\\\\\n",
       "\t6 & 0 & 1 & 1 & 54 & 0 & 0 & 17463            & 51.8625 & 2\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 9\n",
       "\n",
       "| <!--/--> | Survived &lt;fct&gt; | Pclass &lt;fct&gt; | Sex &lt;fct&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Embarked &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 3 | 1 | 22 | 1 | 0 | A/5 21171        |  7.2500 | 2 |\n",
       "| 2 | 1 | 1 | 0 | 38 | 1 | 0 | PC 17599         | 71.2833 | 0 |\n",
       "| 3 | 1 | 3 | 0 | 26 | 0 | 0 | STON/O2. 3101282 |  7.9250 | 2 |\n",
       "| 4 | 1 | 1 | 0 | 35 | 1 | 0 | 113803           | 53.1000 | 2 |\n",
       "| 5 | 0 | 3 | 1 | 35 | 0 | 0 | 373450           |  8.0500 | 2 |\n",
       "| 6 | 0 | 1 | 1 | 54 | 0 | 0 | 17463            | 51.8625 | 2 |\n",
       "\n"
      ],
      "text/plain": [
       "  Survived Pclass Sex Age SibSp Parch Ticket           Fare    Embarked\n",
       "1 0        3      1   22  1     0     A/5 21171         7.2500 2       \n",
       "2 1        1      0   38  1     0     PC 17599         71.2833 0       \n",
       "3 1        3      0   26  0     0     STON/O2. 3101282  7.9250 2       \n",
       "4 1        1      0   35  1     0     113803           53.1000 2       \n",
       "5 0        3      1   35  0     0     373450            8.0500 2       \n",
       "6 0        1      1   54  0     0     17463            51.8625 2       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#With the summary above,I confirmed that some variables have the wrong class\n",
    "#I would carry on to edit this and make corrections \n",
    "#First, I would change that of the Survived to a factor\n",
    "train_no_na$Survived <- factor(train_no_na$Survived , level = c(0,1))\n",
    "\n",
    "#I go on to change the class of the ticket class(Pclass),Sex and Station Embarked\n",
    "train_no_na$Pclass <- factor(train_no_na$Pclass , level = c(1,2,3))\n",
    "train_no_na$Sex <- factor(train_no_na$Sex , level = c(\"female\",\"male\"))\n",
    "train_no_na$Embarked <- factor(train_no_na$Embarked , level = c(\"C\",\"Q\",\"S\"))\n",
    "\n",
    "#recoding the levels of some variables\n",
    "levels(train_no_na$Sex) <- c(0,1)\n",
    "levels(train_no_na$Embarked) <- c(0 , 1 , 2)\n",
    "\n",
    "head(train_no_na)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3378bc92",
   "metadata": {
    "papermill": {
     "duration": 0.006559,
     "end_time": "2022-12-11T21:12:23.194687",
     "exception": false,
     "start_time": "2022-12-11T21:12:23.188128",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Data split and train set and test set determination\n",
    "We would be skipping thus step since the train and test datasets were provided for us explicitly.Although we ought to test our data still,so I would be splitting out dayta set still to do a smaller scale test before we go on to use our model on the test dataset\n",
    "\n",
    "#### Data vizualisation before modelling\n",
    "I want to vizualize the distribution of the datset before i carry on with my model creation.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "566671d7",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:23.211342Z",
     "iopub.status.busy": "2022-12-11T21:12:23.209728Z",
     "iopub.status.idle": "2022-12-11T21:12:24.634774Z",
     "shell.execute_reply": "2022-12-11T21:12:24.632711Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 1.436377,
     "end_time": "2022-12-11T21:12:24.637603",
     "exception": false,
     "start_time": "2022-12-11T21:12:23.201226",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nZubl5YUQysrKkslkusehKSoqKkr3CLGJIeySyWR1dXW6p6DJycjIyMrKCiF4eEC6pJ6DNTU1\ndXV16Z4FNgheigUAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIRFa6BwBYNwqvvDDdI7CyyhBCCAVpnoKVLTrr/HSPQENxxA4AIBLCDgAgEsIOACAS\nMbzHLpFIFBcXp3sKmi4Pjw1EZboHgPVFE/mrWFJSku4RIhRD2CWTyQULFqR7CpqcnJyc/Pz8\nEIKHxwaiWboHgPWFv4oRiyHsQgg1NTXpHoEmJzMzM3XBwwNgRf4qRsx77AAAIiHsAAAiIewA\nACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHs\nAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh\n7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAi\nIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAA\nIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewA\nACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACKRhrCrXFha\nXpds/PsFAIhbViPfX8X8l4475tKdbrznhPYFIYQQ6p6//4ZHJ02ZsShziz7bHzXi6M2aZX69\n7RpWAQCwskY9Ypesq7jpt1eX1tYtW/LRQyOvnvDiwP2PG336EfkfPnPeGbck67EKAIBVNWrY\nvXnnea+12GX59WTVuAnvdhs+dthuA3tvPej0y09Z/MUT981a8h2rAABYncYLu4Uf/G3sk+Wj\nRh+wbEll6aTPKmqHDumYuprbalC/5jmvTJy95lUAAKxWI73Hrq7qy0tG/Xmv397cPX/5++Sq\nlrwVQuiVv3yG3vlZT00tXfOqlDPOOOPDDz9MXe7Vq9fYsWMb+Cdg/ZNIJFIXWrVqld5JaBw1\n6R4A1hdN5K/i/Pnz0z1ChBop7P5x5ch5A0755dbFydrl/xXrKpeEEIqzl6decXZm9cLqNa9K\n+eqrr7744ovU5TZt2mRm+lwF38rDYwMh7KCe/FWMWGOE3Vf/vf72d9rfdMcuKy3PyM0PIcyr\nrmufs/QV4ZLq2qxWWWtelXLQQQfNmzcvdbl169ZLlnj7HSvLysrKzc0NIXh4bCAa+0P+sN7y\nVzFijfGXcM6/36paNOuYA362bMnjxx/ydEG/P98wKISJ08qr2+fkppZPL68p6l0UQsjO3/Lb\nVqXss88+yy5XV1eXli5/lRZScnNzU2FXXl6e7lloDIXpHgDWF/4qRqwxwq7rEb8b9/Olr6Im\n6xae+ZsxO5538YFtW+e1bLNxzo1PTJ6zy9BOIYTqxVNeXVQ1bHD7EEJey8HftgoAgNVqjLDL\na9e5W7ull1PvsWvZuUuX9gUhhDOH9TzrtjHPtTu7Z8vKR/4wrmDj3Yd3LAghhET2t64CAGB1\n0vymlG4HjT25cvy940bNrUh07bfzRWcel6jHKgAAVpVIJtf7L3TwHjtWKzc3t7CwMIRQUlKS\n7lloDIVXXpjuEWD9sOis89M9wlLFxcXpHiE2jfrNEwAANBxhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEImsdA+wDiQSiebNm6d7\nCpqczMzM1AUPD4AVNZG/iosXL073CBFyxA4AIBIxHLFLJpOqn1Xl5uZmZ2cH/1O4wShM9wCw\nvvBXMWKO2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARCKrce6mauH0W6+9bfLbH1ZkFmyyWa8Djj9lx87NQwgh1D1//w2P\nTpoyY1HmFn22P2rE0Zs1y/z6RmtYBQDAyhrniF3yhjPOn1zS/pSRF1963mk9M6dd9ZvfllTX\nhRA+emjk1RNeHLj/caNPPyL/w2fOO+OW5Ne3WcMqAABW1RhhV1n6r+e+Kjv2gpMHbtmje+8B\nx5xzVm3ljAlzykKyatyEd7sNHztst4G9tx50+uWnLP7iiftmLQkhrGkVAACr0xhhl5FVfMwx\nx2xfmLP0eiIrhJCfmVFZOumzitqhQzqmFue2GtSvec4rE2eHENawCgCA1WqM99hlF/T92c/6\nhhDmv/HSlFmzpjz7UJve+wxvm18+860QQq/85TP0zs96amppCKFqybeuSnn00UfnzZuXuty6\ndevBgwc3wg/C+iUra+njp1mzZumdBKBJaSJ/FcvLy9M9QoQa6cMTKbP/89w/Pvji00/LB+6/\naQihrnJJCKE4e/lHIoqzM6sXVq95VcqECROmTZuWuty/f/+f/vSnjfEDsH4qKChI9wg0hsp0\nDwDriybyV1HYNYRGDbuep557ZQhlM18+4dRLLujQ6+wt8kMI86rr2ucsfUW4pLo2q1VWCCEj\n91tXpbRt23bRokWpy23atKmtrW3MH4T1QiKRyMjICCF4eACsyF/FiDVG2C384N///jB37z23\nS13N77jdPhvlPf7PL7O33jKEidPKq9vn5KZWTS+vKepdFELIzv/WVSnjxo1bdrm6unr+/PmN\n8IOwfsnNzS0sLAwheHhsIArTPQCsL/xVjFhjfHiiunziH2+6OnV+kxBCSNb+r6wmf5P8vJaD\nN87JfGLynKWbLZ7y6qKqAYPbhxDWsAoAgNVqjLBr1fOErjmV51x622tT3/vg3TcnXHvWG+W5\nhx/eJSSyzxzW8/3bxjw3ZfrMj96+ddS4go13H96xIISwplUAAKxOIplsjPP+ln3x6g033ztl\n2mc12YWbbNpz7yNOGNyjZQghJGufvmv8hKdfnluR6Npv5xPPPK7bsk/CrmHVN1VXV5eWlq52\nFRuyZS/FlpSUpHsWGkPhlRemewRYPyw66/x0j7BUcXFxukeITSOFXYMSdqyWsNvQCDuoJ2EX\nscb5SjEAABqcsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIRFa6B4hH4ZUXpnsE\nVlYZQgihMM1TsLJFZ52f7hEA4uSIHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AEI9k3ZIJV587ZPveG7UoyMkv2qRr74NOGvn8Z4sb\n9E7P71xU2OG4db7bhZ+OTCQSh703r/43yVrnQwAApEWyrmzETl2ve3F2h62GHnbcfu2Lsme8\n/9pfb7vsoT/dMf6lN0/t17qB7jcjKyuzrkkcLBN2AEAkPvnrwde9OHvgqMcmX7j3soXjLv/X\ntt33PHvXQ0+c88+sRIPc75gP545pkB2vtSZRlwAAP9w7414NIYw7a/cVF+Z3HHzbUd3L5z71\nYEn52u6wrmZB7TqbrjFEEnZZTUC6fwew3vAchPRqoOfg2mqIHy2vVU4I4cE3Vn5T2oCxj02d\nOnX3Vrmpq2f/qEWLH5294gZvXLB1IpH4pLI2hPCnHq1bdb26csHLh+/Sq3nuRotrk3/Z/UcZ\nGZkTS6tWvMmpnVrkFGyxqDYZQrhks5ap99h955aLP510+sF7btKmZW7BRj23GnLBzU/UrbDl\nK/dftts23Qrzclp36H7waeO/qlpxZb3E8KcwkUi0bNky3VOEynQPAOuLBnrCeg5CPTWFfzRD\nCCUlJet8n33OGxae+P34XfvMOP7kYfsMHbLLdq1zM0MIOa02691qLfZTVzPvyP57zR00/JJr\nRzTLSAy+6mfJ/teNeuiTScdsntqgYv4TN8xc3P2I6wszv/Hi7pq3XDLz4f5b/OKzxMaHHX1c\nt+LMN5//y5gT93548p9ev/OoEMJb1x+83akT8lpvdchxZxbXfP7IbWdvN7Hz2v4GYgi7ZDLZ\nEA+OtVWY7gFgfdFAT1jPQainpvCPZgNpt8NVk2/LO3nMtQ9cf9ED11+UkVnYb6dddttt9wMP\nP3LbTVvUfz+LZly84NpXnz51QOpq6y0v65F/81sX3RWOGZta8v6tY5LJ5JmXbr/SDde85VV7\n/PKzRLeJn00Z2DovhBDCZQ+fudXPxx198eifn9Nxzu5nPJjfbp+X33+od2F2CGH0yKO33nyv\n+Wv5G4jkpVgAgBDCwGPGvv5Z6advT/7TNWMP++m2X73+zytHjdi+S+u9Trt9LfaSyL3rhP7L\nr2UUXL1np4WfXvHa4urUkqt+/05B+6OO71Cw8u2+fcuasv9d9M68nifd+XXVhRDC/51/TQhh\nwo3T50w596uq2j3uvD5VdSGEgo2H3H1yz7X98YUdABCZxCZ9Bh414ry7Hn728wULX3n81p3b\n5fzz2mOP+ufn9bx9TvP+bbO/0UgDLzs0maw+57HPQgjlcybcNXvJNheds9rbftuWFfOerE0m\n3/79dokV5LbcOYRQ+nbpV//+JIRw8IDiFXfV9eit1vYnj+GlWACA2srPhh18WsddLr7+tF7L\nlyZyt/m/Yx+ZvKSoy2lPjXkz7NlptbdN1iVXvJrIWPlQXMvuo7cpvPK10Q+Eg89999rLMjKb\nX39o19Xu6lu3zMgJIWx59u1XDum40k1yi/pnvJARQsj45tlYMvLW5o2BqZus7Q0AAJqgzJz2\nk5949J7xd6+6KqeoSwghZ6O8FZZ94zQms1/9rm93SGRfdcCmCz648J2ymotueq/ttlf3zv+W\no2PfsmXeRv+XmUjULOix5wp2/UnnBQsWJDbNbzNosxDC/W/MXXFPXz77yiTTFusAAB5qSURB\nVHf+1CsRdgBAFBI51+29Seknlx02/rlvHH9LVt168ukhhF+M7ZdakJ+ZUTHv8ZLqpScTqZj7\n35Of++I7dz/gguOTdRWn/HnMwyXl+1+339pumZXXbUyvjd6/+8hnvyxbtuV9p+x3yCGHfJYR\nivte2jYn86kjT3tvSU1qVVXpmyeePaW+P/vXvBQLAERi/3ufPXSbre/99a7P3jZo6E7927TI\nK5s36+V/PfrKh6X9j/7jFVstfQfbvsM3v2DsK/2GHHH24UOqv5x2x7hrZhfnhM9r1rzzwk3O\n2LXlyOdOviSnef+rtmrzPbY8/Ykbbtn8sKFd+/z84H237r7R1Ocm3P309C2Punt42/wQNnv6\nqv37jfjLVpsNHH74Xm3D7MfuuLv0x4eGf6zNZz4csQMAopGZt9mf3/zk/qt+u1Xh3Mfv/9O4\n31/z54cnZnfd8+r7Xphy+3HLNtvqguevO+OQwhnPnnXSL88ac+WCLQ9+6oGd67H7xMVHdUvW\nJrsNv67ZdwTU6rdsvskv3nrrsWP22GTSX28bddE1r8zZaPQtT065/fDU2r6/euC/91z8407z\n7r3hsmvu/kfXQ69668HfrO1vIJFMJr97q6aturq6tLQ03VOEwisvTPcIsH5YdNb5DbFbz0Go\npwZ6Dn4PxcXF371RQ6qrXPj5nJpNOm2U3jHWIS/FAgAbqIzcFpus/mOy6ysvxQIARELYAQBE\nor5hN3DgwKs+X7zq8i8njxg0ZPg6HQkAgO/jO95jt/DjD2ZV1YYQ/vvf/3Z59933lqz0BbrJ\nqY9PmvzvTxpqOgAA6u07wu6hvbY/ZvrSczHfu8d2965umxabnrKupwIAYK19R9jtcOG4mxZU\nhBBOPPHEnS+6+pA2zVbaICO7cOABwxpqOgAA6u07wq7HQUf2CCGEcP/99//smF+e0LF5I8wE\nAMD3UN/z2P3rX/8KIcz7/KM5S6pXXdujR491ORQAAGuvvmFXUfLMATsd9MR781a7NoKvrwAA\nWN/VN+z+uN/wJ99f9NOTztmr76ZZiQYdCQBgrS1atKiB9lxYWNhAe17n6ht2Y1+Z0+Wgvz56\nw74NOg0AwPeWM/a8db7PqpEXr/N9Npx6naA4WbtoTnVt54P6NvQ0AAB8b/UKu0Rm811a5n10\nx6sNPQ0AAN9bPb9SLHH/YxdVPXn4URfdOXtJTcNOBADA91Lf99gNO+eRdh2y7zz/qLtGH7tR\n+/bNMr/xAYoZM2Y0wGwAAKyF+oZdcXFxcfFunfs36DAAAHx/9Q27v/3tbw06BwAAP1B9w660\ntHQNa4uKitbFMAAAfH/1DbuWLVuuYa1vngAANki191x44jX3/ePdudk77LLfFbdd0a8wO43T\n1DfsxowZ843ryZqZH73z8IRH5iU2HnPjJet8LACApu/1y3c9YuzbY2+69fcdKq899YTB21aV\nTLu+nuccaQj1DbvRo0evunD8lS/tuvnO46957byjD1unUwEANHl1FcMvmrz12FfOPaZfCGHr\nF0JBh0Mu+ODiC7qt6XXOBvWDmrJZu+1vubB/yZtXTyytXFcDAQCsF8rm3Pe/JdUnHtk9dTW/\n/cG7tcp77N5P0jjSDz1YmN8pP5HI7JGfzpeTAQAaX8WCZ0MIg1rkLFsyqEXuVxO/St9EPyzs\n6qrnXD3qjezmW7XPTuOryQAAaVBTVhpC6JS7/I1tnXIzK0vS+TJmfd9jN3DgwFWW1c16/61P\n51ZsM/K6dTsTAEDTl5XfIoQws6q2a15masnnlbU5HXLWeKOG9UOOtGX8aMshp1107wsXbr/O\nxgEAWE/kFg0OIby4cPkhupcXVbUZ1CZ9E9X7iN2LL77YoHMAAKxfCtoN37zZyTf+9bPDT+wZ\nQqic/4/H55Wfe0SXNI5U37ADAOAbErn3nPPjgb8eeuem9+/QrvzqXw5vufmxY7un7VwnYW3D\nruyLNx585Ol3PppZVpvVoUvvPX42bOsfNW+gyQAAmrhtRj17U9lRY4bv/sWSjAG7HvLMn69J\n7+dJ1yLsHjr/4MMufqCybvm3h513+okHnnfPhAsPaIDBAACavET2sZfdc+xl6R7ja/XNyo//\nctiwiya03fmYCU+/9MVXc+fPmfnKcw8eu0u7By4aNvyvnzTkhAAA1Et9j9hddfrfm2981LRn\nbsnPSKSWbDP4gK13HlrXuf0Dv/p92P8PDTYhAAD1Ut8jdvfPKdv8+NOWVV1KIiP/tFN7lM+5\nrwEGAwBg7dQ37JpnZFTMrlh1ecXsikSmz08AAKRffcPu9O5FH9x18qvzv/EtGVWlU069dXpR\nt9MaYDAAANZOfd9jd/SDF47u/asdN+13zKlH79i3W14o//DtyXdcd/v0spxr/3J0g44IAEB9\n1DfsWvY4+Z2nsw4/+Xc3XXLOTV8v3KjHT66//u4Te6bzRHwAAKSsxXnsOg0+/vl3j/t82mv/\n+3BmZcjt2KXXgC1+lN6z8AEAsMxahF3Jaw+fe8n11cNvveNn24QQntlzqx2z+vx69LhfbJfO\nL7sFAEipGnlxukdIs/qGXen7f9z8xyeVJoqOOW7pQbqNBnT/dPz9hzz16Ny3Pj5pi1YNNiEA\nQL20eO2tdb7PhVv3Xef7bDj1fSn1tp//bkmzrSZ99sUte/0otWTApQ989Nnk7fMrRh34xwYb\nDwCA+qpv2F39QWm3I67bsX2zFRfmtdn22hN7LHj/mgYYDACAtVPfsKtNJnOKclZdnpmfGULd\nOh0JAIDvo75hd+qmLd67eeSMytoVF9ZVzRpz3bTCTic0wGAAAKyd+n544sSHRl3c/ze9ew45\n84yjd+zbLT+j+uN3Xrpz3GXPzK0Z88SpDToiAAD1Ud+w26jPr//3aOaBJ5w3ZsSkZQvzNup5\nwX1/GbWt050AAKTfWpzHbtOhI1759MSp/534+rRPy2qzOnTpvcvO27TITDTccAAA1N9ahF0I\nISRy+gzcvc/AhpkFAGD9dHaPDs2fnn7+JoXpHcNXggEA/BB1rz1w5lXvz65KJtM9ydoesQMA\n4GsfTThqyK/+8umcsnQPspQjdgAA31PHwec89OSkl/7zl3QPspQjdgAA31Ne255btw015QXp\nHmQpR+wAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAi4XQnAAA/SFaznskm8LUTodHCLlkz\n/2+33Pzk5DfnVmR0+FH3fYefuOdW7UMIIdQ9f/8Nj06aMmNR5hZ9tj9qxNGbNcv8+kZrWAUA\nwMoa6aXYpy75zZ+f//KnR424/KLfDulaecOYUx6ZsTiE8NFDI6+e8OLA/Y8bffoR+R8+c94Z\ntyzL3TWsAgBgVY1xxK62csZNr5XsfMlV+/VuFULo3nPLWS8f9MhN0/Yb23fchHe7DR83bLfN\nQgjdLg8HHnnlfbOGH9qhICSrvnUVAACr0xhH7GorPum82Wb/16Xw6wWJrYpyq0oXV5ZO+qyi\nduiQjqmlua0G9Wue88rE2SGENaxKWbJkycKvlZWVJZqARvhNQhw8ByG9Gug5uLbS/WuIU2Mc\nscspGjR+/KBlV6sXT7t95uJNj+tWteSBEEKv/OUz9M7PempqaQihaslb37Yq5YQTTpg2bVrq\ncv/+/W+99dYG/iG+W2W6B4D1RevWrRtit56DUE8N9BxcWyUlJekeIUKN/anYT155/A/X/qmm\ny//9bveNqz9ZEkIozl7+kYji7MzqhdUhhLrKb10FAMBqNV7YVc6fdvs1f/jHm/N2HnbSxYcO\nyUskFuXmhxDmVde1z1n6inBJdW1Wq6wQQsa3r0o555xzysrKUpfz8vJKS0tDuuWlewBYXzTQ\nE9ZzEOqpKfyjSQNppLBb9PEzZ551fWbfoVfcckSP4qV/frPztwxh4rTy6vY5uakl08trinoX\nrXlVSp8+fZZdrq6ubgqPUf+oQD1VVzfI0XfPQainBnoONgULt+6b7hHSrDE+PJGsK7v43Btz\nd/3VDecfv6zqQgh5LQdvnJP5xOQ5qavVi6e8uqhqwOD2a14FAMBqNcYRu7Iv736nrPrYvgWv\nvfrqsoXZzbr361105rCeZ9025rl2Z/dsWfnIH8YVbLz78I4FIYSQyP7WVU1V3tCD0j0CrB/m\npHsAIEqFhYXfvVHsGiPsSt/7JIRw2+UXr7iwqMuou8dv2+2gsSdXjr933Ki5FYmu/Xa+6Mzj\nln36eQ2rAABYVaKJfLXZD9FE3mPXZup76R4B1g9z+vRoiN0WXnlhQ+wW4rPorPPTPcJSxcXF\n6R4hNo30lWIAADQ0YQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABCJrHQPsA4kEomWLVumewqgvhroCVvbEDuFGDWRfzQXLFiQ7hEi\nFEPYJZPJysrKdE8B1FdFRUVD7Da7IXYKMWqg5yBNQQxhFzxGYb0i7CC9/KMZMe+xAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIRFYj398dJx2Zd+FNB7dp9vWCuufvv+HRSVNmLMrcos/2R404erNmmfVYBQDAyhrziF3y\ng//c/reZC2qSyWWLPnpo5NUTXhy4/3GjTz8i/8NnzjvjlmQ9VgEAsKpGOmL35b/Hj/zjC1+V\nVn5jabJq3IR3uw0fN2y3zUII3S4PBx555X2zhh/aoWBNqwAAWJ1GOmK3Ud9h54y+9KrLf7vi\nwsrSSZ9V1A4d0jF1NbfVoH7Nc16ZOHvNqwAAWK1GOmKXU9SpW1GorcpbcWHVkrdCCL3yl8/Q\nOz/rqamla16Vcu21186cOTN1uXPnzsccc0xDjg+sS4WFhekeATZoTeQ5uGjRonSPEKHG/vDE\niuoql4QQirOXfySiODuzemH1mlelvPzyy9OmTUtd7t+//0knndQ4MwM/XG5ubkPstvK7NwFC\naLDn4NoSdg0hnWGXkZsfQphXXdc+Z+krwiXVtVmtsta8KmW77bbr1KlT6nLnzp0rK/1Jh/WG\nJyykl+dgxNIZdtn5W4YwcVp5dfucpf/rML28pqh30ZpXpYwYMWLZ5erq6tLS0gCsJxrof9Ob\nxGtLsD5wqCxi6TxBcV7LwRvnZD4xeU7qavXiKa8uqhowuP2aVwEAsFpp/eaJRPaZw3q+f9uY\n56ZMn/nR27eOGlew8e7DOxZ8xyoAAFYnnS/FhhC6HTT25Mrx944bNbci0bXfzhedeVyiHqsA\nAFhVIplc77/QoYm8x67N1PfSPQKsH+b06dEQuy288sKG2C3EZ9FZ56d7hKWKi4vTPUJs0vpS\nLAAA646wAwCIhLADAIhEmj88AbCu5A09KN0jwPphTroHoOE4YgcAEAlhBwAQCWEHABAJYQcA\n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\n7AAAABTiT9s1QyXEu8WhAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "'Confusion matrix of Sex and Survival'"
      ],
      "text/latex": [
       "'Confusion matrix of Sex and Survival'"
      ],
      "text/markdown": [
       "'Confusion matrix of Sex and Survival'"
      ],
      "text/plain": [
       "[1] \"Confusion matrix of Sex and Survival\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "   \n",
       "      0   1\n",
       "  0  64 197\n",
       "  1 360  93"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I look into the distribution by age and sex\n",
    "train_no_na %>% ggplot(aes(Age , Sex)) + geom_boxplot() + xlab(\"Age of Passenger\")+\n",
    "ylab(\"Gender of passenger\") + labs(title = \"Age Distribution of Passengers by Gender\")\n",
    "\n",
    "#I look into the distibution of the data in both the sex and survival variables\n",
    "train_no_na %>% ggplot(aes(Sex , fill = Survived)) + geom_bar() + labs(title = \"Sex Distribution\")\n",
    "\n",
    "#I try to find a correlation between pasenger age and price\n",
    "train_no_na %>% ggplot(aes(Age , Fare ,color = Pclass)) + geom_point() + labs(title = \"Correlation between age and passenger fare\")\n",
    "\n",
    "#Then I carry on to make a confusion matrix of sex and survival\n",
    "String <- \"Confusion matrix of Sex and Survival\"\n",
    "table_sex_survival <- table(train_no_na$Sex,train_no_na$Survived)\n",
    "String\n",
    "table_sex_survival"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "aa882f0b",
   "metadata": {
    "papermill": {
     "duration": 0.009215,
     "end_time": "2022-12-11T21:12:24.656432",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.647217",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Inference from the vizualisation\n",
    "From the above vizualisations,we can conclude that;\n",
    "* There are more female survivals than there are male.\n",
    "* The ratio of male survivals to dead male is large and that of the female is lesser.\n",
    "* There is no correlation between age and price ticket.\n",
    "* Instead,there is a correlation between passenger class and ticket as the higher the class,the higher the ticket.\n",
    "* There is a large age range for both genders in which the male gender range frm 0 to having outliers at 69-80 , while the female range from 0.2 to 62\n",
    "\n",
    "We now proceed to model defininng and creation\n",
    "\n",
    "## Model creation\n",
    "We would go ahead wth the process of model creation;\n",
    "First, I do train dataset splitting and definition...\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "f30fe744",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:24.678163Z",
     "iopub.status.busy": "2022-12-11T21:12:24.676550Z",
     "iopub.status.idle": "2022-12-11T21:12:24.760110Z",
     "shell.execute_reply": "2022-12-11T21:12:24.758098Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.098067,
     "end_time": "2022-12-11T21:12:24.763604",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.665537",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch + \n",
       "    Fare + Embarked, family = \"binomial\", data = train_1)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-2.7924  -0.6551  -0.3668   0.6155   2.5261  \n",
       "\n",
       "Coefficients:\n",
       "             Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  4.768886   0.591986   8.056 7.90e-16 ***\n",
       "Pclass2     -1.285273   0.351340  -3.658 0.000254 ***\n",
       "Pclass3     -2.565841   0.372889  -6.881 5.94e-12 ***\n",
       "Sex1        -2.686555   0.242695 -11.070  < 2e-16 ***\n",
       "Age         -0.048228   0.009009  -5.353 8.63e-08 ***\n",
       "SibSp       -0.432489   0.141083  -3.065 0.002173 ** \n",
       "Parch       -0.052512   0.130138  -0.404 0.686573    \n",
       "Fare         0.001661   0.002788   0.596 0.551406    \n",
       "Embarked1   -0.435039   0.641918  -0.678 0.497951    \n",
       "Embarked2   -0.508213   0.292021  -1.740 0.081801 .  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 851.87  on 632  degrees of freedom\n",
       "Residual deviance: 551.29  on 623  degrees of freedom\n",
       "  (2 observations deleted due to missingness)\n",
       "AIC: 571.29\n",
       "\n",
       "Number of Fisher Scoring iterations: 5\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "set.seed(50)\n",
    " \n",
    "split_data <- sample.split(train_no_na , SplitRatio = 0.9)\n",
    "train_1 <- subset(train_no_na , split_data == \"TRUE\" )\n",
    "test_1 <- subset(train_no_na , split_data == \"FALSE\" )\n",
    "\n",
    "model <- glm(Survived ~ Pclass+Sex+Age+SibSp +Parch +Fare+Embarked ,train_1 ,family = \"binomial\")\n",
    "summary(model)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7d9679a2",
   "metadata": {
    "papermill": {
     "duration": 0.020138,
     "end_time": "2022-12-11T21:12:24.794282",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.774144",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Optimization of model\n",
    "From the summarry of the model above,w e can make some inferences;\n",
    "The variables without a star or dot do not have a large(significant cotribution) to the model and to optimize the model we take a close look at our Residual deviance and AIC which should not increase and also decrease (respectively) as we remove the variables"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "a39860dd",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:24.819625Z",
     "iopub.status.busy": "2022-12-11T21:12:24.817975Z",
     "iopub.status.idle": "2022-12-11T21:12:24.879298Z",
     "shell.execute_reply": "2022-12-11T21:12:24.877232Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.077211,
     "end_time": "2022-12-11T21:12:24.882318",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.805107",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = Survived ~ Pclass + Sex + Age + SibSp + Fare + \n",
       "    Embarked, family = \"binomial\", data = train_1)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-2.8086  -0.6534  -0.3653   0.6181   2.5314  \n",
       "\n",
       "Coefficients:\n",
       "             Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  4.764274   0.590868   8.063 7.43e-16 ***\n",
       "Pclass2     -1.299554   0.349147  -3.722 0.000198 ***\n",
       "Pclass3     -2.588237   0.368312  -7.027 2.11e-12 ***\n",
       "Sex1        -2.666741   0.237324 -11.237  < 2e-16 ***\n",
       "Age         -0.048305   0.009009  -5.362 8.23e-08 ***\n",
       "SibSp       -0.446760   0.136738  -3.267 0.001086 ** \n",
       "Fare         0.001404   0.002671   0.526 0.599077    \n",
       "Embarked1   -0.433166   0.640818  -0.676 0.499067    \n",
       "Embarked2   -0.509289   0.291868  -1.745 0.080997 .  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 851.87  on 632  degrees of freedom\n",
       "Residual deviance: 551.46  on 624  degrees of freedom\n",
       "  (2 observations deleted due to missingness)\n",
       "AIC: 569.46\n",
       "\n",
       "Number of Fisher Scoring iterations: 5\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch + \n",
       "    Embarked, family = \"binomial\", data = train_1)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-2.7652  -0.6581  -0.3673   0.6123   2.5357  \n",
       "\n",
       "Coefficients:\n",
       "             Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  4.927515   0.534268   9.223  < 2e-16 ***\n",
       "Pclass2     -1.375982   0.317943  -4.328 1.51e-05 ***\n",
       "Pclass3     -2.680355   0.321865  -8.328  < 2e-16 ***\n",
       "Sex1        -2.691328   0.242464 -11.100  < 2e-16 ***\n",
       "Age         -0.048749   0.008976  -5.431 5.61e-08 ***\n",
       "SibSp       -0.423494   0.140022  -3.024  0.00249 ** \n",
       "Parch       -0.034726   0.126727  -0.274  0.78407    \n",
       "Embarked1   -0.458246   0.640966  -0.715  0.47465    \n",
       "Embarked2   -0.535999   0.288168  -1.860  0.06288 .  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 851.87  on 632  degrees of freedom\n",
       "Residual deviance: 551.67  on 624  degrees of freedom\n",
       "  (2 observations deleted due to missingness)\n",
       "AIC: 569.67\n",
       "\n",
       "Number of Fisher Scoring iterations: 5\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch + \n",
       "    Embarked, family = \"binomial\", data = train_1)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-2.7652  -0.6581  -0.3673   0.6123   2.5357  \n",
       "\n",
       "Coefficients:\n",
       "             Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)  4.927515   0.534268   9.223  < 2e-16 ***\n",
       "Pclass2     -1.375982   0.317943  -4.328 1.51e-05 ***\n",
       "Pclass3     -2.680355   0.321865  -8.328  < 2e-16 ***\n",
       "Sex1        -2.691328   0.242464 -11.100  < 2e-16 ***\n",
       "Age         -0.048749   0.008976  -5.431 5.61e-08 ***\n",
       "SibSp       -0.423494   0.140022  -3.024  0.00249 ** \n",
       "Parch       -0.034726   0.126727  -0.274  0.78407    \n",
       "Embarked1   -0.458246   0.640966  -0.715  0.47465    \n",
       "Embarked2   -0.535999   0.288168  -1.860  0.06288 .  \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 851.87  on 632  degrees of freedom\n",
       "Residual deviance: 551.67  on 624  degrees of freedom\n",
       "  (2 observations deleted due to missingness)\n",
       "AIC: 569.67\n",
       "\n",
       "Number of Fisher Scoring iterations: 5\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#the first optimization is by removing the Parch variable\n",
    "model1 <- glm(Survived ~ Pclass+Sex+Age+SibSp +Fare+Embarked ,train_1 ,family = \"binomial\")\n",
    "summary(model1)\n",
    "\n",
    "    #the second optimization is by removing the Fare variable\n",
    "model2 <- glm(Survived ~ Pclass+Sex+Age+SibSp +Parch+Embarked ,train_1 ,family = \"binomial\")\n",
    "summary(model2)\n",
    "\n",
    "#the first optimization is by removing the Parch variable\n",
    "model3 <- glm(Survived ~ Pclass+Sex+Age+SibSp+Embarked ,train_1 ,family = \"binomial\")\n",
    "summary(model2)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "66b33509",
   "metadata": {
    "papermill": {
     "duration": 0.010053,
     "end_time": "2022-12-11T21:12:24.902312",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.892259",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Optimization conclusion\n",
    "Since the  change in residual deviance is not significant and there is a reduction in our AIC, we can go ahead and adopt model3."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "5fbdb9d4",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:24.925766Z",
     "iopub.status.busy": "2022-12-11T21:12:24.924285Z",
     "iopub.status.idle": "2022-12-11T21:12:24.953930Z",
     "shell.execute_reply": "2022-12-11T21:12:24.951431Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.045042,
     "end_time": "2022-12-11T21:12:24.956935",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.911893",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>4</dt><dd>0.903178318351514</dd><dt>13</dt><dd>0.0347987398849326</dd><dt>22</dt><dd>0.499103523614411</dd><dt>31</dt><dd>0.751523911625359</dd><dt>40</dt><dd>0.7593591839945</dd><dt>49</dt><dd>0.0768706161091488</dd><dt>58</dt><dd>0.0726220877679562</dd><dt>67</dt><dd>0.0996021862207424</dd><dt>76</dt><dd>0.751995573707849</dd><dt>85</dt><dd>0.0552238202964552</dd><dt>94</dt><dd>0.742793772282347</dd><dt>103</dt><dd>0.11285064943055</dd><dt>112</dt><dd>0.742793772282347</dd><dt>121</dt><dd>0.150962306212827</dd><dt>130</dt><dd>0.740284546896828</dd><dt>139</dt><dd>0.769685408570988</dd><dt>148</dt><dd>0.81679211015393</dd><dt>157</dt><dd>0.888972847926917</dd><dt>166</dt><dd>0.151775503622566</dd><dt>175</dt><dd>0.103258544965131</dd><dt>184</dt><dd>0.120623332153847</dd><dt>193</dt><dd>0.352978926433391</dd><dt>202</dt><dd>0.0602871794788797</dd><dt>211</dt><dd>0.0535876214609619</dd><dt>220</dt><dd>0.730803774001547</dd><dt>229</dt><dd>0.12859653917799</dd><dt>238</dt><dd>0.627122279294982</dd><dt>247</dt><dd>0.969085059965648</dd><dt>256</dt><dd>0.945960301246444</dd><dt>265</dt><dd>0.43640322392015</dd><dt>274</dt><dd>0.447250164756341</dd><dt>283</dt><dd>0.108283100922819</dd><dt>292</dt><dd>0.0633685108786844</dd><dt>301</dt><dd>0.649622029566139</dd><dt>310</dt><dd>0.0388534029322008</dd><dt>319</dt><dd>0.544552964096049</dd><dt>328</dt><dd>0.145345607003496</dd><dt>337</dt><dd>0.768933948095877</dd><dt>346</dt><dd>0.626095526702285</dd><dt>355</dt><dd>0.123232526402024</dd><dt>364</dt><dd>0.683105112985756</dd><dt>373</dt><dd>0.0552238202964552</dd><dt>382</dt><dd>0.113080326535597</dd><dt>391</dt><dd>0.134650919683605</dd><dt>400</dt><dd>0.678180571597354</dd><dt>409</dt><dd>0.863044255624763</dd><dt>418</dt><dd>0.053044972152114</dd><dt>427</dt><dd>0.969085059965648</dd><dt>436</dt><dd>0.046075910270268</dd><dt>445</dt><dd>0.377660424912969</dd><dt>454</dt><dd>0.485436478663465</dd><dt>463</dt><dd>0.616712357845595</dd><dt>472</dt><dd>0.040058761819284</dd><dt>481</dt><dd>0.883321016477774</dd><dt>490</dt><dd>0.0993968165714534</dd><dt>499</dt><dd>0.0994823831783476</dd><dt>508</dt><dd>0.976742024228743</dd><dt>517</dt><dd>0.709231338417853</dd><dt>526</dt><dd>0.0834302677601982</dd><dt>535</dt><dd>0.101422772394646</dd><dt>544</dt><dd>0.0320606521395865</dd><dt>553</dt><dd>0.0418058038068185</dd><dt>562</dt><dd>0.690771797003889</dd><dt>571</dt><dd>0.843052101747578</dd><dt>580</dt><dd>0.208681673020212</dd><dt>589</dt><dd>0.379250952166478</dd><dt>598</dt><dd>0.914335539494414</dd><dt>607</dt><dd>0.940754615440212</dd><dt>616</dt><dd>0.0346568007988487</dd><dt>625</dt><dd>0.099223095757572</dd><dt>634</dt><dd>0.879223434969397</dd><dt>643</dt><dd>0.0759740419439677</dd><dt>652</dt><dd>0.0777027704657642</dd><dt>661</dt><dd>0.0561141785414699</dd><dt>670</dt><dd>0.0726220877679562</dd><dt>679</dt><dd>0.0511686563956931</dd><dt>688</dt><dd>0.0207406522789105</dd><dt>697</dt><dd>0.838637586503863</dd><dt>706</dt><dd>0.0694069125555602</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[4] 0.903178318351514\n",
       "\\item[13] 0.0347987398849326\n",
       "\\item[22] 0.499103523614411\n",
       "\\item[31] 0.751523911625359\n",
       "\\item[40] 0.7593591839945\n",
       "\\item[49] 0.0768706161091488\n",
       "\\item[58] 0.0726220877679562\n",
       "\\item[67] 0.0996021862207424\n",
       "\\item[76] 0.751995573707849\n",
       "\\item[85] 0.0552238202964552\n",
       "\\item[94] 0.742793772282347\n",
       "\\item[103] 0.11285064943055\n",
       "\\item[112] 0.742793772282347\n",
       "\\item[121] 0.150962306212827\n",
       "\\item[130] 0.740284546896828\n",
       "\\item[139] 0.769685408570988\n",
       "\\item[148] 0.81679211015393\n",
       "\\item[157] 0.888972847926917\n",
       "\\item[166] 0.151775503622566\n",
       "\\item[175] 0.103258544965131\n",
       "\\item[184] 0.120623332153847\n",
       "\\item[193] 0.352978926433391\n",
       "\\item[202] 0.0602871794788797\n",
       "\\item[211] 0.0535876214609619\n",
       "\\item[220] 0.730803774001547\n",
       "\\item[229] 0.12859653917799\n",
       "\\item[238] 0.627122279294982\n",
       "\\item[247] 0.969085059965648\n",
       "\\item[256] 0.945960301246444\n",
       "\\item[265] 0.43640322392015\n",
       "\\item[274] 0.447250164756341\n",
       "\\item[283] 0.108283100922819\n",
       "\\item[292] 0.0633685108786844\n",
       "\\item[301] 0.649622029566139\n",
       "\\item[310] 0.0388534029322008\n",
       "\\item[319] 0.544552964096049\n",
       "\\item[328] 0.145345607003496\n",
       "\\item[337] 0.768933948095877\n",
       "\\item[346] 0.626095526702285\n",
       "\\item[355] 0.123232526402024\n",
       "\\item[364] 0.683105112985756\n",
       "\\item[373] 0.0552238202964552\n",
       "\\item[382] 0.113080326535597\n",
       "\\item[391] 0.134650919683605\n",
       "\\item[400] 0.678180571597354\n",
       "\\item[409] 0.863044255624763\n",
       "\\item[418] 0.053044972152114\n",
       "\\item[427] 0.969085059965648\n",
       "\\item[436] 0.046075910270268\n",
       "\\item[445] 0.377660424912969\n",
       "\\item[454] 0.485436478663465\n",
       "\\item[463] 0.616712357845595\n",
       "\\item[472] 0.040058761819284\n",
       "\\item[481] 0.883321016477774\n",
       "\\item[490] 0.0993968165714534\n",
       "\\item[499] 0.0994823831783476\n",
       "\\item[508] 0.976742024228743\n",
       "\\item[517] 0.709231338417853\n",
       "\\item[526] 0.0834302677601982\n",
       "\\item[535] 0.101422772394646\n",
       "\\item[544] 0.0320606521395865\n",
       "\\item[553] 0.0418058038068185\n",
       "\\item[562] 0.690771797003889\n",
       "\\item[571] 0.843052101747578\n",
       "\\item[580] 0.208681673020212\n",
       "\\item[589] 0.379250952166478\n",
       "\\item[598] 0.914335539494414\n",
       "\\item[607] 0.940754615440212\n",
       "\\item[616] 0.0346568007988487\n",
       "\\item[625] 0.099223095757572\n",
       "\\item[634] 0.879223434969397\n",
       "\\item[643] 0.0759740419439677\n",
       "\\item[652] 0.0777027704657642\n",
       "\\item[661] 0.0561141785414699\n",
       "\\item[670] 0.0726220877679562\n",
       "\\item[679] 0.0511686563956931\n",
       "\\item[688] 0.0207406522789105\n",
       "\\item[697] 0.838637586503863\n",
       "\\item[706] 0.0694069125555602\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "4\n",
       ":   0.90317831835151413\n",
       ":   0.034798739884932622\n",
       ":   0.49910352361441131\n",
       ":   0.75152391162535940\n",
       ":   0.759359183994549\n",
       ":   0.076870616109148858\n",
       ":   0.072622087767956267\n",
       ":   0.099602186220742476\n",
       ":   0.75199557370784985\n",
       ":   0.055223820296455294\n",
       ":   0.742793772282347103\n",
       ":   0.11285064943055112\n",
       ":   0.742793772282347121\n",
       ":   0.150962306212827130\n",
       ":   0.740284546896828139\n",
       ":   0.769685408570988148\n",
       ":   0.81679211015393157\n",
       ":   0.888972847926917166\n",
       ":   0.151775503622566175\n",
       ":   0.103258544965131184\n",
       ":   0.120623332153847193\n",
       ":   0.352978926433391202\n",
       ":   0.0602871794788797211\n",
       ":   0.0535876214609619220\n",
       ":   0.730803774001547229\n",
       ":   0.12859653917799238\n",
       ":   0.627122279294982247\n",
       ":   0.969085059965648256\n",
       ":   0.945960301246444265\n",
       ":   0.43640322392015274\n",
       ":   0.447250164756341283\n",
       ":   0.108283100922819292\n",
       ":   0.0633685108786844301\n",
       ":   0.649622029566139310\n",
       ":   0.0388534029322008319\n",
       ":   0.544552964096049328\n",
       ":   0.145345607003496337\n",
       ":   0.768933948095877346\n",
       ":   0.626095526702285355\n",
       ":   0.123232526402024364\n",
       ":   0.683105112985756373\n",
       ":   0.0552238202964552382\n",
       ":   0.113080326535597391\n",
       ":   0.134650919683605400\n",
       ":   0.678180571597354409\n",
       ":   0.863044255624763418\n",
       ":   0.053044972152114427\n",
       ":   0.969085059965648436\n",
       ":   0.046075910270268445\n",
       ":   0.377660424912969454\n",
       ":   0.485436478663465463\n",
       ":   0.616712357845595472\n",
       ":   0.040058761819284481\n",
       ":   0.883321016477774490\n",
       ":   0.0993968165714534499\n",
       ":   0.0994823831783476508\n",
       ":   0.976742024228743517\n",
       ":   0.709231338417853526\n",
       ":   0.0834302677601982535\n",
       ":   0.101422772394646544\n",
       ":   0.0320606521395865553\n",
       ":   0.0418058038068185562\n",
       ":   0.690771797003889571\n",
       ":   0.843052101747578580\n",
       ":   0.208681673020212589\n",
       ":   0.379250952166478598\n",
       ":   0.914335539494414607\n",
       ":   0.940754615440212616\n",
       ":   0.0346568007988487625\n",
       ":   0.099223095757572634\n",
       ":   0.879223434969397643\n",
       ":   0.0759740419439677652\n",
       ":   0.0777027704657642661\n",
       ":   0.0561141785414699670\n",
       ":   0.0726220877679562679\n",
       ":   0.0511686563956931688\n",
       ":   0.0207406522789105697\n",
       ":   0.838637586503863706\n",
       ":   0.0694069125555602\n",
       "\n"
      ],
      "text/plain": [
       "         4         13         22         31         40         49         58 \n",
       "0.90317832 0.03479874 0.49910352 0.75152391 0.75935918 0.07687062 0.07262209 \n",
       "        67         76         85         94        103        112        121 \n",
       "0.09960219 0.75199557 0.05522382 0.74279377 0.11285065 0.74279377 0.15096231 \n",
       "       130        139        148        157        166        175        184 \n",
       "0.74028455 0.76968541 0.81679211 0.88897285 0.15177550 0.10325854 0.12062333 \n",
       "       193        202        211        220        229        238        247 \n",
       "0.35297893 0.06028718 0.05358762 0.73080377 0.12859654 0.62712228 0.96908506 \n",
       "       256        265        274        283        292        301        310 \n",
       "0.94596030 0.43640322 0.44725016 0.10828310 0.06336851 0.64962203 0.03885340 \n",
       "       319        328        337        346        355        364        373 \n",
       "0.54455296 0.14534561 0.76893395 0.62609553 0.12323253 0.68310511 0.05522382 \n",
       "       382        391        400        409        418        427        436 \n",
       "0.11308033 0.13465092 0.67818057 0.86304426 0.05304497 0.96908506 0.04607591 \n",
       "       445        454        463        472        481        490        499 \n",
       "0.37766042 0.48543648 0.61671236 0.04005876 0.88332102 0.09939682 0.09948238 \n",
       "       508        517        526        535        544        553        562 \n",
       "0.97674202 0.70923134 0.08343027 0.10142277 0.03206065 0.04180580 0.69077180 \n",
       "       571        580        589        598        607        616        625 \n",
       "0.84305210 0.20868167 0.37925095 0.91433554 0.94075462 0.03465680 0.09922310 \n",
       "       634        643        652        661        670        679        688 \n",
       "0.87922343 0.07597404 0.07770277 0.05611418 0.07262209 0.05116866 0.02074065 \n",
       "       697        706 \n",
       "0.83863759 0.06940691 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "regression <- predict(model3,test_1 , type = \"response\")\n",
    "regression"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4f658209",
   "metadata": {
    "papermill": {
     "duration": 0.010192,
     "end_time": "2022-12-11T21:12:24.977699",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.967507",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**After model creation**\n",
    "Since we hacve created our model and tested with our test model,we can make a confussion matrix of the predictions and the label on the dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "96a017ff",
   "metadata": {
    "_kg_hide-output": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.077301Z",
     "iopub.status.busy": "2022-12-11T21:12:25.000078Z",
     "iopub.status.idle": "2022-12-11T21:12:25.097700Z",
     "shell.execute_reply": "2022-12-11T21:12:25.095556Z"
    },
    "papermill": {
     "duration": 0.112713,
     "end_time": "2022-12-11T21:12:25.100719",
     "exception": false,
     "start_time": "2022-12-11T21:12:24.988006",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "      Predicted\n",
       "Actual FALSE TRUE\n",
       "     0    35    9\n",
       "     1    12   23"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "Table <- table(Actual = test_1$Survived , Predicted = regression > 0.5)\n",
    "Table"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "b74dc49b",
   "metadata": {
    "_kg_hide-output": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.125850Z",
     "iopub.status.busy": "2022-12-11T21:12:25.124261Z",
     "iopub.status.idle": "2022-12-11T21:12:25.144567Z",
     "shell.execute_reply": "2022-12-11T21:12:25.142418Z"
    },
    "papermill": {
     "duration": 0.036159,
     "end_time": "2022-12-11T21:12:25.147355",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.111196",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "73.4177215189873"
      ],
      "text/latex": [
       "73.4177215189873"
      ],
      "text/markdown": [
       "73.4177215189873"
      ],
      "text/plain": [
       "[1] 73.41772"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "accuracy <- (35+23) / (35 +9 +12 +23)\n",
    "accuracy * 100"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "60159e29",
   "metadata": {
    "papermill": {
     "duration": 0.01034,
     "end_time": "2022-12-11T21:12:25.167850",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.157510",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Conclusion\n",
    "From the calculation of our accuracy,we can conclude that our model has an accuracy of 73.42%."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0f121ca5",
   "metadata": {
    "papermill": {
     "duration": 0.010219,
     "end_time": "2022-12-11T21:12:25.188270",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.178051",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Next step\n",
    "Now,I would proceed to apply my model on the test data that has been provided for the competition."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "3e65f328",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.213082Z",
     "iopub.status.busy": "2022-12-11T21:12:25.211371Z",
     "iopub.status.idle": "2022-12-11T21:12:25.276250Z",
     "shell.execute_reply": "2022-12-11T21:12:25.274424Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.080256,
     "end_time": "2022-12-11T21:12:25.278650",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.198394",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 10</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Pclass</th><th scope=col>Name</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Embarked</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>892</td><td>3</td><td>Kelly, Mr. James                            </td><td>1</td><td>34.5</td><td>0</td><td>0</td><td>330911 </td><td> 7.8292</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>893</td><td>3</td><td>Wilkes, Mrs. James (Ellen Needs)            </td><td>0</td><td>47.0</td><td>1</td><td>0</td><td>363272 </td><td> 7.0000</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>894</td><td>2</td><td>Myles, Mr. Thomas Francis                   </td><td>1</td><td>62.0</td><td>0</td><td>0</td><td>240276 </td><td> 9.6875</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>895</td><td>3</td><td>Wirz, Mr. Albert                            </td><td>1</td><td>27.0</td><td>0</td><td>0</td><td>315154 </td><td> 8.6625</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>896</td><td>3</td><td>Hirvonen, Mrs. Alexander (Helga E Lindqvist)</td><td>0</td><td>22.0</td><td>1</td><td>1</td><td>3101298</td><td>12.2875</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>897</td><td>3</td><td>Svensson, Mr. Johan Cervin                  </td><td>1</td><td>14.0</td><td>0</td><td>0</td><td>7538   </td><td> 9.2250</td><td>2</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 10\n",
       "\\begin{tabular}{r|llllllllll}\n",
       "  & PassengerId & Pclass & Name & Sex & Age & SibSp & Parch & Ticket & Fare & Embarked\\\\\n",
       "  & <int> & <fct> & <chr> & <fct> & <dbl> & <int> & <int> & <chr> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & 892 & 3 & Kelly, Mr. James                             & 1 & 34.5 & 0 & 0 & 330911  &  7.8292 & 1\\\\\n",
       "\t2 & 893 & 3 & Wilkes, Mrs. James (Ellen Needs)             & 0 & 47.0 & 1 & 0 & 363272  &  7.0000 & 2\\\\\n",
       "\t3 & 894 & 2 & Myles, Mr. Thomas Francis                    & 1 & 62.0 & 0 & 0 & 240276  &  9.6875 & 1\\\\\n",
       "\t4 & 895 & 3 & Wirz, Mr. Albert                             & 1 & 27.0 & 0 & 0 & 315154  &  8.6625 & 2\\\\\n",
       "\t5 & 896 & 3 & Hirvonen, Mrs. Alexander (Helga E Lindqvist) & 0 & 22.0 & 1 & 1 & 3101298 & 12.2875 & 2\\\\\n",
       "\t6 & 897 & 3 & Svensson, Mr. Johan Cervin                   & 1 & 14.0 & 0 & 0 & 7538    &  9.2250 & 2\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 10\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Pclass &lt;fct&gt; | Name &lt;chr&gt; | Sex &lt;fct&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Embarked &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 892 | 3 | Kelly, Mr. James                             | 1 | 34.5 | 0 | 0 | 330911  |  7.8292 | 1 |\n",
       "| 2 | 893 | 3 | Wilkes, Mrs. James (Ellen Needs)             | 0 | 47.0 | 1 | 0 | 363272  |  7.0000 | 2 |\n",
       "| 3 | 894 | 2 | Myles, Mr. Thomas Francis                    | 1 | 62.0 | 0 | 0 | 240276  |  9.6875 | 1 |\n",
       "| 4 | 895 | 3 | Wirz, Mr. Albert                             | 1 | 27.0 | 0 | 0 | 315154  |  8.6625 | 2 |\n",
       "| 5 | 896 | 3 | Hirvonen, Mrs. Alexander (Helga E Lindqvist) | 0 | 22.0 | 1 | 1 | 3101298 | 12.2875 | 2 |\n",
       "| 6 | 897 | 3 | Svensson, Mr. Johan Cervin                   | 1 | 14.0 | 0 | 0 | 7538    |  9.2250 | 2 |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Pclass Name                                         Sex Age \n",
       "1 892         3      Kelly, Mr. James                             1   34.5\n",
       "2 893         3      Wilkes, Mrs. James (Ellen Needs)             0   47.0\n",
       "3 894         2      Myles, Mr. Thomas Francis                    1   62.0\n",
       "4 895         3      Wirz, Mr. Albert                             1   27.0\n",
       "5 896         3      Hirvonen, Mrs. Alexander (Helga E Lindqvist) 0   22.0\n",
       "6 897         3      Svensson, Mr. Johan Cervin                   1   14.0\n",
       "  SibSp Parch Ticket  Fare    Embarked\n",
       "1 0     0     330911   7.8292 1       \n",
       "2 1     0     363272   7.0000 2       \n",
       "3 0     0     240276   9.6875 1       \n",
       "4 0     0     315154   8.6625 2       \n",
       "5 1     1     3101298 12.2875 2       \n",
       "6 0     0     7538     9.2250 2       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "  PassengerId     Pclass      Name           Sex          Age       \n",
       " Min.   : 892.0   1: 98   Length:331         0:127   Min.   : 0.17  \n",
       " 1st Qu.: 992.5   2: 88   Class :character   1:204   1st Qu.:21.00  \n",
       " Median :1100.0   3:145   Mode  :character           Median :27.00  \n",
       " Mean   :1100.2                                      Mean   :30.18  \n",
       " 3rd Qu.:1210.5                                      3rd Qu.:39.00  \n",
       " Max.   :1307.0                                      Max.   :76.00  \n",
       "     SibSp            Parch           Ticket               Fare        Embarked\n",
       " Min.   :0.0000   Min.   :0.0000   Length:331         Min.   :  0.00   0: 82   \n",
       " 1st Qu.:0.0000   1st Qu.:0.0000   Class :character   1st Qu.:  8.05   1: 22   \n",
       " Median :0.0000   Median :0.0000   Mode  :character   Median : 16.00   2:227   \n",
       " Mean   :0.4834   Mean   :0.3988                      Mean   : 40.98           \n",
       " 3rd Qu.:1.0000   3rd Qu.:1.0000                      3rd Qu.: 40.63           \n",
       " Max.   :8.0000   Max.   :6.0000                      Max.   :512.33           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I would perform data cleaning on the test dataseyt that was provided for me\n",
    "test <- read.csv(\"/kaggle/input/titanic/test.csv\")\n",
    "# I would remove the variable that is not needed and drop NA values\n",
    "test <- test %>% select(-10) %>%\n",
    "                      drop_na()\n",
    "#I would then convert variables to factor\n",
    "test$Pclass <- factor(test$Pclass , level = c(1,2,3))\n",
    "test$Sex <- factor(test$Sex , level = c(\"female\",\"male\"))\n",
    "test$Embarked <- factor(test$Embarked , level = c(\"C\",\"Q\",\"S\"))\n",
    "\n",
    "#I would recode the levels of factors Sex and Embarked\n",
    "levels(test$Sex) <- c(0,1)\n",
    "levels(test$Embarked) <- c(0 , 1 , 2)\n",
    "\n",
    "head(test)\n",
    "summary(test)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "d7b9b736",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.305428Z",
     "iopub.status.busy": "2022-12-11T21:12:25.303728Z",
     "iopub.status.idle": "2022-12-11T21:12:25.334610Z",
     "shell.execute_reply": "2022-12-11T21:12:25.332983Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.060068,
     "end_time": "2022-12-11T21:12:25.350441",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.290373",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>1</dt><dd>FALSE</dd><dt>2</dt><dd>FALSE</dd><dt>3</dt><dd>FALSE</dd><dt>4</dt><dd>FALSE</dd><dt>5</dt><dd>TRUE</dd><dt>6</dt><dd>FALSE</dd><dt>7</dt><dd>TRUE</dd><dt>8</dt><dd>FALSE</dd><dt>9</dt><dd>TRUE</dd><dt>10</dt><dd>FALSE</dd><dt>11</dt><dd>FALSE</dd><dt>12</dt><dd>TRUE</dd><dt>13</dt><dd>FALSE</dd><dt>14</dt><dd>TRUE</dd><dt>15</dt><dd>TRUE</dd><dt>16</dt><dd>FALSE</dd><dt>17</dt><dd>FALSE</dd><dt>18</dt><dd>FALSE</dd><dt>19</dt><dd>TRUE</dd><dt>20</dt><dd>FALSE</dd><dt>21</dt><dd>FALSE</dd><dt>22</dt><dd>TRUE</dd><dt>23</dt><dd>TRUE</dd><dt>24</dt><dd>FALSE</dd><dt>25</dt><dd>TRUE</dd><dt>26</dt><dd>FALSE</dd><dt>27</dt><dd>FALSE</dd><dt>28</dt><dd>FALSE</dd><dt>29</dt><dd>FALSE</dd><dt>30</dt><dd>FALSE</dd><dt>31</dt><dd>TRUE</dd><dt>32</dt><dd>FALSE</dd><dt>33</dt><dd>TRUE</dd><dt>34</dt><dd>FALSE</dd><dt>35</dt><dd>FALSE</dd><dt>36</dt><dd>FALSE</dd><dt>37</dt><dd>TRUE</dd><dt>38</dt><dd>TRUE</dd><dt>39</dt><dd>FALSE</dd><dt>40</dt><dd>TRUE</dd><dt>41</dt><dd>TRUE</dd><dt>42</dt><dd>FALSE</dd><dt>43</dt><dd>TRUE</dd><dt>44</dt><dd>FALSE</dd><dt>45</dt><dd>TRUE</dd><dt>46</dt><dd>TRUE</dd><dt>47</dt><dd>FALSE</dd><dt>48</dt><dd>FALSE</dd><dt>49</dt><dd>FALSE</dd><dt>50</dt><dd>TRUE</dd><dt>51</dt><dd>FALSE</dd><dt>52</dt><dd>FALSE</dd><dt>53</dt><dd>FALSE</dd><dt>54</dt><dd>TRUE</dd><dt>55</dt><dd>TRUE</dd><dt>56</dt><dd>TRUE</dd><dt>57</dt><dd>FALSE</dd><dt>58</dt><dd>TRUE</dd><dt>59</dt><dd>TRUE</dd><dt>60</dt><dd>TRUE</dd><dt>61</dt><dd>FALSE</dd><dt>62</dt><dd>TRUE</dd><dt>63</dt><dd>TRUE</dd><dt>64</dt><dd>TRUE</dd><dt>65</dt><dd>TRUE</dd><dt>66</dt><dd>TRUE</dd><dt>67</dt><dd>FALSE</dd><dt>68</dt><dd>TRUE</dd><dt>69</dt><dd>FALSE</dd><dt>70</dt><dd>FALSE</dd><dt>71</dt><dd>FALSE</dd><dt>72</dt><dd>TRUE</dd><dt>73</dt><dd>TRUE</dd><dt>74</dt><dd>FALSE</dd><dt>75</dt><dd>TRUE</dd><dt>76</dt><dd>TRUE</dd><dt>77</dt><dd>TRUE</dd><dt>78</dt><dd>FALSE</dd><dt>79</dt><dd>TRUE</dd><dt>80</dt><dd>FALSE</dd><dt>81</dt><dd>TRUE</dd><dt>82</dt><dd>FALSE</dd><dt>83</dt><dd>TRUE</dd><dt>84</dt><dd>FALSE</dd><dt>85</dt><dd>FALSE</dd><dt>86</dt><dd>TRUE</dd><dt>87</dt><dd>FALSE</dd><dt>88</dt><dd>FALSE</dd><dt>89</dt><dd>FALSE</dd><dt>90</dt><dd>FALSE</dd><dt>91</dt><dd>TRUE</dd><dt>92</dt><dd>TRUE</dd><dt>93</dt><dd>TRUE</dd><dt>94</dt><dd>FALSE</dd><dt>95</dt><dd>TRUE</dd><dt>96</dt><dd>TRUE</dd><dt>97</dt><dd>TRUE</dd><dt>98</dt><dd>TRUE</dd><dt>99</dt><dd>TRUE</dd><dt>100</dt><dd>FALSE</dd><dt>101</dt><dd>TRUE</dd><dt>102</dt><dd>FALSE</dd><dt>103</dt><dd>FALSE</dd><dt>104</dt><dd>FALSE</dd><dt>105</dt><dd>FALSE</dd><dt>106</dt><dd>FALSE</dd><dt>107</dt><dd>FALSE</dd><dt>108</dt><dd>FALSE</dd><dt>109</dt><dd>FALSE</dd><dt>110</dt><dd>FALSE</dd><dt>111</dt><dd>TRUE</dd><dt>112</dt><dd>FALSE</dd><dt>113</dt><dd>FALSE</dd><dt>114</dt><dd>TRUE</dd><dt>115</dt><dd>FALSE</dd><dt>116</dt><dd>FALSE</dd><dt>117</dt><dd>FALSE</dd><dt>118</dt><dd>FALSE</dd><dt>119</dt><dd>FALSE</dd><dt>120</dt><dd>FALSE</dd><dt>121</dt><dd>TRUE</dd><dt>122</dt><dd>FALSE</dd><dt>123</dt><dd>FALSE</dd><dt>124</dt><dd>FALSE</dd><dt>125</dt><dd>TRUE</dd><dt>126</dt><dd>TRUE</dd><dt>127</dt><dd>FALSE</dd><dt>128</dt><dd>TRUE</dd><dt>129</dt><dd>FALSE</dd><dt>130</dt><dd>TRUE</dd><dt>131</dt><dd>FALSE</dd><dt>132</dt><dd>FALSE</dd><dt>133</dt><dd>FALSE</dd><dt>134</dt><dd>FALSE</dd><dt>135</dt><dd>TRUE</dd><dt>136</dt><dd>FALSE</dd><dt>137</dt><dd>FALSE</dd><dt>138</dt><dd>FALSE</dd><dt>139</dt><dd>TRUE</dd><dt>140</dt><dd>TRUE</dd><dt>141</dt><dd>FALSE</dd><dt>142</dt><dd>TRUE</dd><dt>143</dt><dd>TRUE</dd><dt>144</dt><dd>FALSE</dd><dt>145</dt><dd>FALSE</dd><dt>146</dt><dd>TRUE</dd><dt>147</dt><dd>TRUE</dd><dt>148</dt><dd>FALSE</dd><dt>149</dt><dd>TRUE</dd><dt>150</dt><dd>FALSE</dd><dt>151</dt><dd>FALSE</dd><dt>152</dt><dd>FALSE</dd><dt>153</dt><dd>FALSE</dd><dt>154</dt><dd>FALSE</dd><dt>155</dt><dd>FALSE</dd><dt>156</dt><dd>FALSE</dd><dt>157</dt><dd>TRUE</dd><dt>158</dt><dd>TRUE</dd><dt>159</dt><dd>FALSE</dd><dt>160</dt><dd>FALSE</dd><dt>161</dt><dd>FALSE</dd><dt>162</dt><dd>TRUE</dd><dt>163</dt><dd>FALSE</dd><dt>164</dt><dd>TRUE</dd><dt>165</dt><dd>FALSE</dd><dt>166</dt><dd>TRUE</dd><dt>167</dt><dd>FALSE</dd><dt>168</dt><dd>FALSE</dd><dt>169</dt><dd>FALSE</dd><dt>170</dt><dd>FALSE</dd><dt>171</dt><dd>FALSE</dd><dt>172</dt><dd>FALSE</dd><dt>173</dt><dd>FALSE</dd><dt>174</dt><dd>TRUE</dd><dt>175</dt><dd>TRUE</dd><dt>176</dt><dd>FALSE</dd><dt>177</dt><dd>TRUE</dd><dt>178</dt><dd>FALSE</dd><dt>179</dt><dd>TRUE</dd><dt>180</dt><dd>FALSE</dd><dt>181</dt><dd>FALSE</dd><dt>182</dt><dd>FALSE</dd><dt>183</dt><dd>FALSE</dd><dt>184</dt><dd>TRUE</dd><dt>185</dt><dd>FALSE</dd><dt>186</dt><dd>FALSE</dd><dt>187</dt><dd>FALSE</dd><dt>188</dt><dd>FALSE</dd><dt>189</dt><dd>FALSE</dd><dt>190</dt><dd>TRUE</dd><dt>191</dt><dd>TRUE</dd><dt>192</dt><dd>TRUE</dd><dt>193</dt><dd>TRUE</dd><dt>194</dt><dd>FALSE</dd><dt>195</dt><dd>FALSE</dd><dt>196</dt><dd>TRUE</dd><dt>197</dt><dd>FALSE</dd><dt>198</dt><dd>TRUE</dd><dt>199</dt><dd>TRUE</dd><dt>200</dt><dd>FALSE</dd><dt>201</dt><dd>TRUE</dd><dt>202</dt><dd>FALSE</dd><dt>203</dt><dd>FALSE</dd><dt>204</dt><dd>FALSE</dd><dt>205</dt><dd>TRUE</dd><dt>206</dt><dd>FALSE</dd><dt>207</dt><dd>FALSE</dd><dt>208</dt><dd>FALSE</dd><dt>209</dt><dd>TRUE</dd><dt>210</dt><dd>TRUE</dd><dt>211</dt><dd>FALSE</dd><dt>212</dt><dd>FALSE</dd><dt>213</dt><dd>FALSE</dd><dt>214</dt><dd>TRUE</dd><dt>215</dt><dd>TRUE</dd><dt>216</dt><dd>FALSE</dd><dt>217</dt><dd>FALSE</dd><dt>218</dt><dd>FALSE</dd><dt>219</dt><dd>FALSE</dd><dt>220</dt><dd>TRUE</dd><dt>221</dt><dd>FALSE</dd><dt>222</dt><dd>TRUE</dd><dt>223</dt><dd>TRUE</dd><dt>224</dt><dd>FALSE</dd><dt>225</dt><dd>TRUE</dd><dt>226</dt><dd>TRUE</dd><dt>227</dt><dd>FALSE</dd><dt>228</dt><dd>FALSE</dd><dt>229</dt><dd>FALSE</dd><dt>230</dt><dd>TRUE</dd><dt>231</dt><dd>TRUE</dd><dt>232</dt><dd>FALSE</dd><dt>233</dt><dd>FALSE</dd><dt>234</dt><dd>FALSE</dd><dt>235</dt><dd>FALSE</dd><dt>236</dt><dd>TRUE</dd><dt>237</dt><dd>FALSE</dd><dt>238</dt><dd>FALSE</dd><dt>239</dt><dd>FALSE</dd><dt>240</dt><dd>FALSE</dd><dt>241</dt><dd>FALSE</dd><dt>242</dt><dd>FALSE</dd><dt>243</dt><dd>FALSE</dd><dt>244</dt><dd>TRUE</dd><dt>245</dt><dd>TRUE</dd><dt>246</dt><dd>FALSE</dd><dt>247</dt><dd>FALSE</dd><dt>248</dt><dd>FALSE</dd><dt>249</dt><dd>FALSE</dd><dt>250</dt><dd>FALSE</dd><dt>251</dt><dd>FALSE</dd><dt>252</dt><dd>FALSE</dd><dt>253</dt><dd>TRUE</dd><dt>254</dt><dd>TRUE</dd><dt>255</dt><dd>FALSE</dd><dt>256</dt><dd>TRUE</dd><dt>257</dt><dd>FALSE</dd><dt>258</dt><dd>FALSE</dd><dt>259</dt><dd>FALSE</dd><dt>260</dt><dd>TRUE</dd><dt>261</dt><dd>TRUE</dd><dt>262</dt><dd>TRUE</dd><dt>263</dt><dd>FALSE</dd><dt>264</dt><dd>TRUE</dd><dt>265</dt><dd>FALSE</dd><dt>266</dt><dd>FALSE</dd><dt>267</dt><dd>FALSE</dd><dt>268</dt><dd>FALSE</dd><dt>269</dt><dd>FALSE</dd><dt>270</dt><dd>TRUE</dd><dt>271</dt><dd>TRUE</dd><dt>272</dt><dd>FALSE</dd><dt>273</dt><dd>TRUE</dd><dt>274</dt><dd>FALSE</dd><dt>275</dt><dd>TRUE</dd><dt>276</dt><dd>TRUE</dd><dt>277</dt><dd>FALSE</dd><dt>278</dt><dd>FALSE</dd><dt>279</dt><dd>FALSE</dd><dt>280</dt><dd>TRUE</dd><dt>281</dt><dd>FALSE</dd><dt>282</dt><dd>TRUE</dd><dt>283</dt><dd>FALSE</dd><dt>284</dt><dd>FALSE</dd><dt>285</dt><dd>TRUE</dd><dt>286</dt><dd>TRUE</dd><dt>287</dt><dd>FALSE</dd><dt>288</dt><dd>TRUE</dd><dt>289</dt><dd>TRUE</dd><dt>290</dt><dd>TRUE</dd><dt>291</dt><dd>FALSE</dd><dt>292</dt><dd>FALSE</dd><dt>293</dt><dd>TRUE</dd><dt>294</dt><dd>FALSE</dd><dt>295</dt><dd>FALSE</dd><dt>296</dt><dd>TRUE</dd><dt>297</dt><dd>TRUE</dd><dt>298</dt><dd>FALSE</dd><dt>299</dt><dd>FALSE</dd><dt>300</dt><dd>FALSE</dd><dt>301</dt><dd>FALSE</dd><dt>302</dt><dd>FALSE</dd><dt>303</dt><dd>TRUE</dd><dt>304</dt><dd>TRUE</dd><dt>305</dt><dd>FALSE</dd><dt>306</dt><dd>FALSE</dd><dt>307</dt><dd>FALSE</dd><dt>308</dt><dd>FALSE</dd><dt>309</dt><dd>TRUE</dd><dt>310</dt><dd>TRUE</dd><dt>311</dt><dd>FALSE</dd><dt>312</dt><dd>FALSE</dd><dt>313</dt><dd>FALSE</dd><dt>314</dt><dd>TRUE</dd><dt>315</dt><dd>FALSE</dd><dt>316</dt><dd>TRUE</dd><dt>317</dt><dd>FALSE</dd><dt>318</dt><dd>FALSE</dd><dt>319</dt><dd>TRUE</dd><dt>320</dt><dd>FALSE</dd><dt>321</dt><dd>TRUE</dd><dt>322</dt><dd>TRUE</dd><dt>323</dt><dd>FALSE</dd><dt>324</dt><dd>FALSE</dd><dt>325</dt><dd>FALSE</dd><dt>326</dt><dd>FALSE</dd><dt>327</dt><dd>TRUE</dd><dt>328</dt><dd>TRUE</dd><dt>329</dt><dd>TRUE</dd><dt>330</dt><dd>TRUE</dd><dt>331</dt><dd>FALSE</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[1] FALSE\n",
       "\\item[2] FALSE\n",
       "\\item[3] FALSE\n",
       "\\item[4] FALSE\n",
       "\\item[5] TRUE\n",
       "\\item[6] FALSE\n",
       "\\item[7] TRUE\n",
       "\\item[8] FALSE\n",
       "\\item[9] TRUE\n",
       "\\item[10] FALSE\n",
       "\\item[11] FALSE\n",
       "\\item[12] TRUE\n",
       "\\item[13] FALSE\n",
       "\\item[14] TRUE\n",
       "\\item[15] TRUE\n",
       "\\item[16] FALSE\n",
       "\\item[17] FALSE\n",
       "\\item[18] FALSE\n",
       "\\item[19] TRUE\n",
       "\\item[20] FALSE\n",
       "\\item[21] FALSE\n",
       "\\item[22] TRUE\n",
       "\\item[23] TRUE\n",
       "\\item[24] FALSE\n",
       "\\item[25] TRUE\n",
       "\\item[26] FALSE\n",
       "\\item[27] FALSE\n",
       "\\item[28] FALSE\n",
       "\\item[29] FALSE\n",
       "\\item[30] FALSE\n",
       "\\item[31] TRUE\n",
       "\\item[32] FALSE\n",
       "\\item[33] TRUE\n",
       "\\item[34] FALSE\n",
       "\\item[35] FALSE\n",
       "\\item[36] FALSE\n",
       "\\item[37] TRUE\n",
       "\\item[38] TRUE\n",
       "\\item[39] FALSE\n",
       "\\item[40] TRUE\n",
       "\\item[41] TRUE\n",
       "\\item[42] FALSE\n",
       "\\item[43] TRUE\n",
       "\\item[44] FALSE\n",
       "\\item[45] TRUE\n",
       "\\item[46] TRUE\n",
       "\\item[47] FALSE\n",
       "\\item[48] FALSE\n",
       "\\item[49] FALSE\n",
       "\\item[50] TRUE\n",
       "\\item[51] FALSE\n",
       "\\item[52] FALSE\n",
       "\\item[53] FALSE\n",
       "\\item[54] TRUE\n",
       "\\item[55] TRUE\n",
       "\\item[56] TRUE\n",
       "\\item[57] FALSE\n",
       "\\item[58] TRUE\n",
       "\\item[59] TRUE\n",
       "\\item[60] TRUE\n",
       "\\item[61] FALSE\n",
       "\\item[62] TRUE\n",
       "\\item[63] TRUE\n",
       "\\item[64] TRUE\n",
       "\\item[65] TRUE\n",
       "\\item[66] TRUE\n",
       "\\item[67] FALSE\n",
       "\\item[68] TRUE\n",
       "\\item[69] FALSE\n",
       "\\item[70] FALSE\n",
       "\\item[71] FALSE\n",
       "\\item[72] TRUE\n",
       "\\item[73] TRUE\n",
       "\\item[74] FALSE\n",
       "\\item[75] TRUE\n",
       "\\item[76] TRUE\n",
       "\\item[77] TRUE\n",
       "\\item[78] FALSE\n",
       "\\item[79] TRUE\n",
       "\\item[80] FALSE\n",
       "\\item[81] TRUE\n",
       "\\item[82] FALSE\n",
       "\\item[83] TRUE\n",
       "\\item[84] FALSE\n",
       "\\item[85] FALSE\n",
       "\\item[86] TRUE\n",
       "\\item[87] FALSE\n",
       "\\item[88] FALSE\n",
       "\\item[89] FALSE\n",
       "\\item[90] FALSE\n",
       "\\item[91] TRUE\n",
       "\\item[92] TRUE\n",
       "\\item[93] TRUE\n",
       "\\item[94] FALSE\n",
       "\\item[95] TRUE\n",
       "\\item[96] TRUE\n",
       "\\item[97] TRUE\n",
       "\\item[98] TRUE\n",
       "\\item[99] TRUE\n",
       "\\item[100] FALSE\n",
       "\\item[101] TRUE\n",
       "\\item[102] FALSE\n",
       "\\item[103] FALSE\n",
       "\\item[104] FALSE\n",
       "\\item[105] FALSE\n",
       "\\item[106] FALSE\n",
       "\\item[107] FALSE\n",
       "\\item[108] FALSE\n",
       "\\item[109] FALSE\n",
       "\\item[110] FALSE\n",
       "\\item[111] TRUE\n",
       "\\item[112] FALSE\n",
       "\\item[113] FALSE\n",
       "\\item[114] TRUE\n",
       "\\item[115] FALSE\n",
       "\\item[116] FALSE\n",
       "\\item[117] FALSE\n",
       "\\item[118] FALSE\n",
       "\\item[119] FALSE\n",
       "\\item[120] FALSE\n",
       "\\item[121] TRUE\n",
       "\\item[122] FALSE\n",
       "\\item[123] FALSE\n",
       "\\item[124] FALSE\n",
       "\\item[125] TRUE\n",
       "\\item[126] TRUE\n",
       "\\item[127] FALSE\n",
       "\\item[128] TRUE\n",
       "\\item[129] FALSE\n",
       "\\item[130] TRUE\n",
       "\\item[131] FALSE\n",
       "\\item[132] FALSE\n",
       "\\item[133] FALSE\n",
       "\\item[134] FALSE\n",
       "\\item[135] TRUE\n",
       "\\item[136] FALSE\n",
       "\\item[137] FALSE\n",
       "\\item[138] FALSE\n",
       "\\item[139] TRUE\n",
       "\\item[140] TRUE\n",
       "\\item[141] FALSE\n",
       "\\item[142] TRUE\n",
       "\\item[143] TRUE\n",
       "\\item[144] FALSE\n",
       "\\item[145] FALSE\n",
       "\\item[146] TRUE\n",
       "\\item[147] TRUE\n",
       "\\item[148] FALSE\n",
       "\\item[149] TRUE\n",
       "\\item[150] FALSE\n",
       "\\item[151] FALSE\n",
       "\\item[152] FALSE\n",
       "\\item[153] FALSE\n",
       "\\item[154] FALSE\n",
       "\\item[155] FALSE\n",
       "\\item[156] FALSE\n",
       "\\item[157] TRUE\n",
       "\\item[158] TRUE\n",
       "\\item[159] FALSE\n",
       "\\item[160] FALSE\n",
       "\\item[161] FALSE\n",
       "\\item[162] TRUE\n",
       "\\item[163] FALSE\n",
       "\\item[164] TRUE\n",
       "\\item[165] FALSE\n",
       "\\item[166] TRUE\n",
       "\\item[167] FALSE\n",
       "\\item[168] FALSE\n",
       "\\item[169] FALSE\n",
       "\\item[170] FALSE\n",
       "\\item[171] FALSE\n",
       "\\item[172] FALSE\n",
       "\\item[173] FALSE\n",
       "\\item[174] TRUE\n",
       "\\item[175] TRUE\n",
       "\\item[176] FALSE\n",
       "\\item[177] TRUE\n",
       "\\item[178] FALSE\n",
       "\\item[179] TRUE\n",
       "\\item[180] FALSE\n",
       "\\item[181] FALSE\n",
       "\\item[182] FALSE\n",
       "\\item[183] FALSE\n",
       "\\item[184] TRUE\n",
       "\\item[185] FALSE\n",
       "\\item[186] FALSE\n",
       "\\item[187] FALSE\n",
       "\\item[188] FALSE\n",
       "\\item[189] FALSE\n",
       "\\item[190] TRUE\n",
       "\\item[191] TRUE\n",
       "\\item[192] TRUE\n",
       "\\item[193] TRUE\n",
       "\\item[194] FALSE\n",
       "\\item[195] FALSE\n",
       "\\item[196] TRUE\n",
       "\\item[197] FALSE\n",
       "\\item[198] TRUE\n",
       "\\item[199] TRUE\n",
       "\\item[200] FALSE\n",
       "\\item[201] TRUE\n",
       "\\item[202] FALSE\n",
       "\\item[203] FALSE\n",
       "\\item[204] FALSE\n",
       "\\item[205] TRUE\n",
       "\\item[206] FALSE\n",
       "\\item[207] FALSE\n",
       "\\item[208] FALSE\n",
       "\\item[209] TRUE\n",
       "\\item[210] TRUE\n",
       "\\item[211] FALSE\n",
       "\\item[212] FALSE\n",
       "\\item[213] FALSE\n",
       "\\item[214] TRUE\n",
       "\\item[215] TRUE\n",
       "\\item[216] FALSE\n",
       "\\item[217] FALSE\n",
       "\\item[218] FALSE\n",
       "\\item[219] FALSE\n",
       "\\item[220] TRUE\n",
       "\\item[221] FALSE\n",
       "\\item[222] TRUE\n",
       "\\item[223] TRUE\n",
       "\\item[224] FALSE\n",
       "\\item[225] TRUE\n",
       "\\item[226] TRUE\n",
       "\\item[227] FALSE\n",
       "\\item[228] FALSE\n",
       "\\item[229] FALSE\n",
       "\\item[230] TRUE\n",
       "\\item[231] TRUE\n",
       "\\item[232] FALSE\n",
       "\\item[233] FALSE\n",
       "\\item[234] FALSE\n",
       "\\item[235] FALSE\n",
       "\\item[236] TRUE\n",
       "\\item[237] FALSE\n",
       "\\item[238] FALSE\n",
       "\\item[239] FALSE\n",
       "\\item[240] FALSE\n",
       "\\item[241] FALSE\n",
       "\\item[242] FALSE\n",
       "\\item[243] FALSE\n",
       "\\item[244] TRUE\n",
       "\\item[245] TRUE\n",
       "\\item[246] FALSE\n",
       "\\item[247] FALSE\n",
       "\\item[248] FALSE\n",
       "\\item[249] FALSE\n",
       "\\item[250] FALSE\n",
       "\\item[251] FALSE\n",
       "\\item[252] FALSE\n",
       "\\item[253] TRUE\n",
       "\\item[254] TRUE\n",
       "\\item[255] FALSE\n",
       "\\item[256] TRUE\n",
       "\\item[257] FALSE\n",
       "\\item[258] FALSE\n",
       "\\item[259] FALSE\n",
       "\\item[260] TRUE\n",
       "\\item[261] TRUE\n",
       "\\item[262] TRUE\n",
       "\\item[263] FALSE\n",
       "\\item[264] TRUE\n",
       "\\item[265] FALSE\n",
       "\\item[266] FALSE\n",
       "\\item[267] FALSE\n",
       "\\item[268] FALSE\n",
       "\\item[269] FALSE\n",
       "\\item[270] TRUE\n",
       "\\item[271] TRUE\n",
       "\\item[272] FALSE\n",
       "\\item[273] TRUE\n",
       "\\item[274] FALSE\n",
       "\\item[275] TRUE\n",
       "\\item[276] TRUE\n",
       "\\item[277] FALSE\n",
       "\\item[278] FALSE\n",
       "\\item[279] FALSE\n",
       "\\item[280] TRUE\n",
       "\\item[281] FALSE\n",
       "\\item[282] TRUE\n",
       "\\item[283] FALSE\n",
       "\\item[284] FALSE\n",
       "\\item[285] TRUE\n",
       "\\item[286] TRUE\n",
       "\\item[287] FALSE\n",
       "\\item[288] TRUE\n",
       "\\item[289] TRUE\n",
       "\\item[290] TRUE\n",
       "\\item[291] FALSE\n",
       "\\item[292] FALSE\n",
       "\\item[293] TRUE\n",
       "\\item[294] FALSE\n",
       "\\item[295] FALSE\n",
       "\\item[296] TRUE\n",
       "\\item[297] TRUE\n",
       "\\item[298] FALSE\n",
       "\\item[299] FALSE\n",
       "\\item[300] FALSE\n",
       "\\item[301] FALSE\n",
       "\\item[302] FALSE\n",
       "\\item[303] TRUE\n",
       "\\item[304] TRUE\n",
       "\\item[305] FALSE\n",
       "\\item[306] FALSE\n",
       "\\item[307] FALSE\n",
       "\\item[308] FALSE\n",
       "\\item[309] TRUE\n",
       "\\item[310] TRUE\n",
       "\\item[311] FALSE\n",
       "\\item[312] FALSE\n",
       "\\item[313] FALSE\n",
       "\\item[314] TRUE\n",
       "\\item[315] FALSE\n",
       "\\item[316] TRUE\n",
       "\\item[317] FALSE\n",
       "\\item[318] FALSE\n",
       "\\item[319] TRUE\n",
       "\\item[320] FALSE\n",
       "\\item[321] TRUE\n",
       "\\item[322] TRUE\n",
       "\\item[323] FALSE\n",
       "\\item[324] FALSE\n",
       "\\item[325] FALSE\n",
       "\\item[326] FALSE\n",
       "\\item[327] TRUE\n",
       "\\item[328] TRUE\n",
       "\\item[329] TRUE\n",
       "\\item[330] TRUE\n",
       "\\item[331] FALSE\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "1\n",
       ":   FALSE2\n",
       ":   FALSE3\n",
       ":   FALSE4\n",
       ":   FALSE5\n",
       ":   TRUE6\n",
       ":   FALSE7\n",
       ":   TRUE8\n",
       ":   FALSE9\n",
       ":   TRUE10\n",
       ":   FALSE11\n",
       ":   FALSE12\n",
       ":   TRUE13\n",
       ":   FALSE14\n",
       ":   TRUE15\n",
       ":   TRUE16\n",
       ":   FALSE17\n",
       ":   FALSE18\n",
       ":   FALSE19\n",
       ":   TRUE20\n",
       ":   FALSE21\n",
       ":   FALSE22\n",
       ":   TRUE23\n",
       ":   TRUE24\n",
       ":   FALSE25\n",
       ":   TRUE26\n",
       ":   FALSE27\n",
       ":   FALSE28\n",
       ":   FALSE29\n",
       ":   FALSE30\n",
       ":   FALSE31\n",
       ":   TRUE32\n",
       ":   FALSE33\n",
       ":   TRUE34\n",
       ":   FALSE35\n",
       ":   FALSE36\n",
       ":   FALSE37\n",
       ":   TRUE38\n",
       ":   TRUE39\n",
       ":   FALSE40\n",
       ":   TRUE41\n",
       ":   TRUE42\n",
       ":   FALSE43\n",
       ":   TRUE44\n",
       ":   FALSE45\n",
       ":   TRUE46\n",
       ":   TRUE47\n",
       ":   FALSE48\n",
       ":   FALSE49\n",
       ":   FALSE50\n",
       ":   TRUE51\n",
       ":   FALSE52\n",
       ":   FALSE53\n",
       ":   FALSE54\n",
       ":   TRUE55\n",
       ":   TRUE56\n",
       ":   TRUE57\n",
       ":   FALSE58\n",
       ":   TRUE59\n",
       ":   TRUE60\n",
       ":   TRUE61\n",
       ":   FALSE62\n",
       ":   TRUE63\n",
       ":   TRUE64\n",
       ":   TRUE65\n",
       ":   TRUE66\n",
       ":   TRUE67\n",
       ":   FALSE68\n",
       ":   TRUE69\n",
       ":   FALSE70\n",
       ":   FALSE71\n",
       ":   FALSE72\n",
       ":   TRUE73\n",
       ":   TRUE74\n",
       ":   FALSE75\n",
       ":   TRUE76\n",
       ":   TRUE77\n",
       ":   TRUE78\n",
       ":   FALSE79\n",
       ":   TRUE80\n",
       ":   FALSE81\n",
       ":   TRUE82\n",
       ":   FALSE83\n",
       ":   TRUE84\n",
       ":   FALSE85\n",
       ":   FALSE86\n",
       ":   TRUE87\n",
       ":   FALSE88\n",
       ":   FALSE89\n",
       ":   FALSE90\n",
       ":   FALSE91\n",
       ":   TRUE92\n",
       ":   TRUE93\n",
       ":   TRUE94\n",
       ":   FALSE95\n",
       ":   TRUE96\n",
       ":   TRUE97\n",
       ":   TRUE98\n",
       ":   TRUE99\n",
       ":   TRUE100\n",
       ":   FALSE101\n",
       ":   TRUE102\n",
       ":   FALSE103\n",
       ":   FALSE104\n",
       ":   FALSE105\n",
       ":   FALSE106\n",
       ":   FALSE107\n",
       ":   FALSE108\n",
       ":   FALSE109\n",
       ":   FALSE110\n",
       ":   FALSE111\n",
       ":   TRUE112\n",
       ":   FALSE113\n",
       ":   FALSE114\n",
       ":   TRUE115\n",
       ":   FALSE116\n",
       ":   FALSE117\n",
       ":   FALSE118\n",
       ":   FALSE119\n",
       ":   FALSE120\n",
       ":   FALSE121\n",
       ":   TRUE122\n",
       ":   FALSE123\n",
       ":   FALSE124\n",
       ":   FALSE125\n",
       ":   TRUE126\n",
       ":   TRUE127\n",
       ":   FALSE128\n",
       ":   TRUE129\n",
       ":   FALSE130\n",
       ":   TRUE131\n",
       ":   FALSE132\n",
       ":   FALSE133\n",
       ":   FALSE134\n",
       ":   FALSE135\n",
       ":   TRUE136\n",
       ":   FALSE137\n",
       ":   FALSE138\n",
       ":   FALSE139\n",
       ":   TRUE140\n",
       ":   TRUE141\n",
       ":   FALSE142\n",
       ":   TRUE143\n",
       ":   TRUE144\n",
       ":   FALSE145\n",
       ":   FALSE146\n",
       ":   TRUE147\n",
       ":   TRUE148\n",
       ":   FALSE149\n",
       ":   TRUE150\n",
       ":   FALSE151\n",
       ":   FALSE152\n",
       ":   FALSE153\n",
       ":   FALSE154\n",
       ":   FALSE155\n",
       ":   FALSE156\n",
       ":   FALSE157\n",
       ":   TRUE158\n",
       ":   TRUE159\n",
       ":   FALSE160\n",
       ":   FALSE161\n",
       ":   FALSE162\n",
       ":   TRUE163\n",
       ":   FALSE164\n",
       ":   TRUE165\n",
       ":   FALSE166\n",
       ":   TRUE167\n",
       ":   FALSE168\n",
       ":   FALSE169\n",
       ":   FALSE170\n",
       ":   FALSE171\n",
       ":   FALSE172\n",
       ":   FALSE173\n",
       ":   FALSE174\n",
       ":   TRUE175\n",
       ":   TRUE176\n",
       ":   FALSE177\n",
       ":   TRUE178\n",
       ":   FALSE179\n",
       ":   TRUE180\n",
       ":   FALSE181\n",
       ":   FALSE182\n",
       ":   FALSE183\n",
       ":   FALSE184\n",
       ":   TRUE185\n",
       ":   FALSE186\n",
       ":   FALSE187\n",
       ":   FALSE188\n",
       ":   FALSE189\n",
       ":   FALSE190\n",
       ":   TRUE191\n",
       ":   TRUE192\n",
       ":   TRUE193\n",
       ":   TRUE194\n",
       ":   FALSE195\n",
       ":   FALSE196\n",
       ":   TRUE197\n",
       ":   FALSE198\n",
       ":   TRUE199\n",
       ":   TRUE200\n",
       ":   FALSE201\n",
       ":   TRUE202\n",
       ":   FALSE203\n",
       ":   FALSE204\n",
       ":   FALSE205\n",
       ":   TRUE206\n",
       ":   FALSE207\n",
       ":   FALSE208\n",
       ":   FALSE209\n",
       ":   TRUE210\n",
       ":   TRUE211\n",
       ":   FALSE212\n",
       ":   FALSE213\n",
       ":   FALSE214\n",
       ":   TRUE215\n",
       ":   TRUE216\n",
       ":   FALSE217\n",
       ":   FALSE218\n",
       ":   FALSE219\n",
       ":   FALSE220\n",
       ":   TRUE221\n",
       ":   FALSE222\n",
       ":   TRUE223\n",
       ":   TRUE224\n",
       ":   FALSE225\n",
       ":   TRUE226\n",
       ":   TRUE227\n",
       ":   FALSE228\n",
       ":   FALSE229\n",
       ":   FALSE230\n",
       ":   TRUE231\n",
       ":   TRUE232\n",
       ":   FALSE233\n",
       ":   FALSE234\n",
       ":   FALSE235\n",
       ":   FALSE236\n",
       ":   TRUE237\n",
       ":   FALSE238\n",
       ":   FALSE239\n",
       ":   FALSE240\n",
       ":   FALSE241\n",
       ":   FALSE242\n",
       ":   FALSE243\n",
       ":   FALSE244\n",
       ":   TRUE245\n",
       ":   TRUE246\n",
       ":   FALSE247\n",
       ":   FALSE248\n",
       ":   FALSE249\n",
       ":   FALSE250\n",
       ":   FALSE251\n",
       ":   FALSE252\n",
       ":   FALSE253\n",
       ":   TRUE254\n",
       ":   TRUE255\n",
       ":   FALSE256\n",
       ":   TRUE257\n",
       ":   FALSE258\n",
       ":   FALSE259\n",
       ":   FALSE260\n",
       ":   TRUE261\n",
       ":   TRUE262\n",
       ":   TRUE263\n",
       ":   FALSE264\n",
       ":   TRUE265\n",
       ":   FALSE266\n",
       ":   FALSE267\n",
       ":   FALSE268\n",
       ":   FALSE269\n",
       ":   FALSE270\n",
       ":   TRUE271\n",
       ":   TRUE272\n",
       ":   FALSE273\n",
       ":   TRUE274\n",
       ":   FALSE275\n",
       ":   TRUE276\n",
       ":   TRUE277\n",
       ":   FALSE278\n",
       ":   FALSE279\n",
       ":   FALSE280\n",
       ":   TRUE281\n",
       ":   FALSE282\n",
       ":   TRUE283\n",
       ":   FALSE284\n",
       ":   FALSE285\n",
       ":   TRUE286\n",
       ":   TRUE287\n",
       ":   FALSE288\n",
       ":   TRUE289\n",
       ":   TRUE290\n",
       ":   TRUE291\n",
       ":   FALSE292\n",
       ":   FALSE293\n",
       ":   TRUE294\n",
       ":   FALSE295\n",
       ":   FALSE296\n",
       ":   TRUE297\n",
       ":   TRUE298\n",
       ":   FALSE299\n",
       ":   FALSE300\n",
       ":   FALSE301\n",
       ":   FALSE302\n",
       ":   FALSE303\n",
       ":   TRUE304\n",
       ":   TRUE305\n",
       ":   FALSE306\n",
       ":   FALSE307\n",
       ":   FALSE308\n",
       ":   FALSE309\n",
       ":   TRUE310\n",
       ":   TRUE311\n",
       ":   FALSE312\n",
       ":   FALSE313\n",
       ":   FALSE314\n",
       ":   TRUE315\n",
       ":   FALSE316\n",
       ":   TRUE317\n",
       ":   FALSE318\n",
       ":   FALSE319\n",
       ":   TRUE320\n",
       ":   FALSE321\n",
       ":   TRUE322\n",
       ":   TRUE323\n",
       ":   FALSE324\n",
       ":   FALSE325\n",
       ":   FALSE326\n",
       ":   FALSE327\n",
       ":   TRUE328\n",
       ":   TRUE329\n",
       ":   TRUE330\n",
       ":   TRUE331\n",
       ":   FALSE\n",
       "\n"
      ],
      "text/plain": [
       "    1     2     3     4     5     6     7     8     9    10    11    12    13 \n",
       "FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE \n",
       "   14    15    16    17    18    19    20    21    22    23    24    25    26 \n",
       " TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE \n",
       "   27    28    29    30    31    32    33    34    35    36    37    38    39 \n",
       "FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE \n",
       "   40    41    42    43    44    45    46    47    48    49    50    51    52 \n",
       " TRUE  TRUE FALSE  TRUE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE \n",
       "   53    54    55    56    57    58    59    60    61    62    63    64    65 \n",
       "FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE \n",
       "   66    67    68    69    70    71    72    73    74    75    76    77    78 \n",
       " TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE \n",
       "   79    80    81    82    83    84    85    86    87    88    89    90    91 \n",
       " TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE \n",
       "   92    93    94    95    96    97    98    99   100   101   102   103   104 \n",
       " TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE \n",
       "  105   106   107   108   109   110   111   112   113   114   115   116   117 \n",
       "FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE \n",
       "  118   119   120   121   122   123   124   125   126   127   128   129   130 \n",
       "FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE \n",
       "  131   132   133   134   135   136   137   138   139   140   141   142   143 \n",
       "FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE  TRUE \n",
       "  144   145   146   147   148   149   150   151   152   153   154   155   156 \n",
       "FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE \n",
       "  157   158   159   160   161   162   163   164   165   166   167   168   169 \n",
       " TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE \n",
       "  170   171   172   173   174   175   176   177   178   179   180   181   182 \n",
       "FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE \n",
       "  183   184   185   186   187   188   189   190   191   192   193   194   195 \n",
       "FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE \n",
       "  196   197   198   199   200   201   202   203   204   205   206   207   208 \n",
       " TRUE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE \n",
       "  209   210   211   212   213   214   215   216   217   218   219   220   221 \n",
       " TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE \n",
       "  222   223   224   225   226   227   228   229   230   231   232   233   234 \n",
       " TRUE  TRUE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE \n",
       "  235   236   237   238   239   240   241   242   243   244   245   246   247 \n",
       "FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE \n",
       "  248   249   250   251   252   253   254   255   256   257   258   259   260 \n",
       "FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE \n",
       "  261   262   263   264   265   266   267   268   269   270   271   272   273 \n",
       " TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE \n",
       "  274   275   276   277   278   279   280   281   282   283   284   285   286 \n",
       "FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE  TRUE  TRUE \n",
       "  287   288   289   290   291   292   293   294   295   296   297   298   299 \n",
       "FALSE  TRUE  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE FALSE \n",
       "  300   301   302   303   304   305   306   307   308   309   310   311   312 \n",
       "FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE \n",
       "  313   314   315   316   317   318   319   320   321   322   323   324   325 \n",
       "FALSE  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE  TRUE  TRUE FALSE FALSE FALSE \n",
       "  326   327   328   329   330   331 \n",
       "FALSE  TRUE  TRUE  TRUE  TRUE FALSE "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I then go ahead to predict the category\n",
    "reg_test <- predict(model3,test,type = \"response\") > 0.5\n",
    "reg_test"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "dc9d060a",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.379076Z",
     "iopub.status.busy": "2022-12-11T21:12:25.377340Z",
     "iopub.status.idle": "2022-12-11T21:12:25.407772Z",
     "shell.execute_reply": "2022-12-11T21:12:25.406148Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.047319,
     "end_time": "2022-12-11T21:12:25.410187",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.362868",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 11</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Pclass</th><th scope=col>Name</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Embarked</th><th scope=col>reg_test</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;lgl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>892</td><td>3</td><td>Kelly, Mr. James                            </td><td>1</td><td>34.5</td><td>0</td><td>0</td><td>330911 </td><td> 7.8292</td><td>1</td><td>FALSE</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>893</td><td>3</td><td>Wilkes, Mrs. James (Ellen Needs)            </td><td>0</td><td>47.0</td><td>1</td><td>0</td><td>363272 </td><td> 7.0000</td><td>2</td><td>FALSE</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>894</td><td>2</td><td>Myles, Mr. Thomas Francis                   </td><td>1</td><td>62.0</td><td>0</td><td>0</td><td>240276 </td><td> 9.6875</td><td>1</td><td>FALSE</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>895</td><td>3</td><td>Wirz, Mr. Albert                            </td><td>1</td><td>27.0</td><td>0</td><td>0</td><td>315154 </td><td> 8.6625</td><td>2</td><td>FALSE</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>896</td><td>3</td><td>Hirvonen, Mrs. Alexander (Helga E Lindqvist)</td><td>0</td><td>22.0</td><td>1</td><td>1</td><td>3101298</td><td>12.2875</td><td>2</td><td> TRUE</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>897</td><td>3</td><td>Svensson, Mr. Johan Cervin                  </td><td>1</td><td>14.0</td><td>0</td><td>0</td><td>7538   </td><td> 9.2250</td><td>2</td><td>FALSE</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 11\n",
       "\\begin{tabular}{r|lllllllllll}\n",
       "  & PassengerId & Pclass & Name & Sex & Age & SibSp & Parch & Ticket & Fare & Embarked & reg\\_test\\\\\n",
       "  & <int> & <fct> & <chr> & <fct> & <dbl> & <int> & <int> & <chr> & <dbl> & <fct> & <lgl>\\\\\n",
       "\\hline\n",
       "\t1 & 892 & 3 & Kelly, Mr. James                             & 1 & 34.5 & 0 & 0 & 330911  &  7.8292 & 1 & FALSE\\\\\n",
       "\t2 & 893 & 3 & Wilkes, Mrs. James (Ellen Needs)             & 0 & 47.0 & 1 & 0 & 363272  &  7.0000 & 2 & FALSE\\\\\n",
       "\t3 & 894 & 2 & Myles, Mr. Thomas Francis                    & 1 & 62.0 & 0 & 0 & 240276  &  9.6875 & 1 & FALSE\\\\\n",
       "\t4 & 895 & 3 & Wirz, Mr. Albert                             & 1 & 27.0 & 0 & 0 & 315154  &  8.6625 & 2 & FALSE\\\\\n",
       "\t5 & 896 & 3 & Hirvonen, Mrs. Alexander (Helga E Lindqvist) & 0 & 22.0 & 1 & 1 & 3101298 & 12.2875 & 2 &  TRUE\\\\\n",
       "\t6 & 897 & 3 & Svensson, Mr. Johan Cervin                   & 1 & 14.0 & 0 & 0 & 7538    &  9.2250 & 2 & FALSE\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 11\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Pclass &lt;fct&gt; | Name &lt;chr&gt; | Sex &lt;fct&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Embarked &lt;fct&gt; | reg_test &lt;lgl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 892 | 3 | Kelly, Mr. James                             | 1 | 34.5 | 0 | 0 | 330911  |  7.8292 | 1 | FALSE |\n",
       "| 2 | 893 | 3 | Wilkes, Mrs. James (Ellen Needs)             | 0 | 47.0 | 1 | 0 | 363272  |  7.0000 | 2 | FALSE |\n",
       "| 3 | 894 | 2 | Myles, Mr. Thomas Francis                    | 1 | 62.0 | 0 | 0 | 240276  |  9.6875 | 1 | FALSE |\n",
       "| 4 | 895 | 3 | Wirz, Mr. Albert                             | 1 | 27.0 | 0 | 0 | 315154  |  8.6625 | 2 | FALSE |\n",
       "| 5 | 896 | 3 | Hirvonen, Mrs. Alexander (Helga E Lindqvist) | 0 | 22.0 | 1 | 1 | 3101298 | 12.2875 | 2 |  TRUE |\n",
       "| 6 | 897 | 3 | Svensson, Mr. Johan Cervin                   | 1 | 14.0 | 0 | 0 | 7538    |  9.2250 | 2 | FALSE |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Pclass Name                                         Sex Age \n",
       "1 892         3      Kelly, Mr. James                             1   34.5\n",
       "2 893         3      Wilkes, Mrs. James (Ellen Needs)             0   47.0\n",
       "3 894         2      Myles, Mr. Thomas Francis                    1   62.0\n",
       "4 895         3      Wirz, Mr. Albert                             1   27.0\n",
       "5 896         3      Hirvonen, Mrs. Alexander (Helga E Lindqvist) 0   22.0\n",
       "6 897         3      Svensson, Mr. Johan Cervin                   1   14.0\n",
       "  SibSp Parch Ticket  Fare    Embarked reg_test\n",
       "1 0     0     330911   7.8292 1        FALSE   \n",
       "2 1     0     363272   7.0000 2        FALSE   \n",
       "3 0     0     240276   9.6875 1        FALSE   \n",
       "4 0     0     315154   8.6625 2        FALSE   \n",
       "5 1     1     3101298 12.2875 2         TRUE   \n",
       "6 0     0     7538     9.2250 2        FALSE   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I combine the test dataset and the predictions\n",
    "test <- cbind(test , reg_test)\n",
    "head(test)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1452feb1",
   "metadata": {
    "papermill": {
     "duration": 0.012497,
     "end_time": "2022-12-11T21:12:25.435466",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.422969",
     "status": "completed"
    },
    "tags": []
   },
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "7c99da48",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.463701Z",
     "iopub.status.busy": "2022-12-11T21:12:25.462116Z",
     "iopub.status.idle": "2022-12-11T21:12:25.497124Z",
     "shell.execute_reply": "2022-12-11T21:12:25.494770Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.052229,
     "end_time": "2022-12-11T21:12:25.499927",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.447698",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 11</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Pclass</th><th scope=col>Name</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Embarked</th><th scope=col>reg_test</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>892</td><td>3</td><td>Kelly, Mr. James                            </td><td>1</td><td>34.5</td><td>0</td><td>0</td><td>330911 </td><td> 7.8292</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>893</td><td>3</td><td>Wilkes, Mrs. James (Ellen Needs)            </td><td>0</td><td>47.0</td><td>1</td><td>0</td><td>363272 </td><td> 7.0000</td><td>2</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>894</td><td>2</td><td>Myles, Mr. Thomas Francis                   </td><td>1</td><td>62.0</td><td>0</td><td>0</td><td>240276 </td><td> 9.6875</td><td>1</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>895</td><td>3</td><td>Wirz, Mr. Albert                            </td><td>1</td><td>27.0</td><td>0</td><td>0</td><td>315154 </td><td> 8.6625</td><td>2</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>896</td><td>3</td><td>Hirvonen, Mrs. Alexander (Helga E Lindqvist)</td><td>0</td><td>22.0</td><td>1</td><td>1</td><td>3101298</td><td>12.2875</td><td>2</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>897</td><td>3</td><td>Svensson, Mr. Johan Cervin                  </td><td>1</td><td>14.0</td><td>0</td><td>0</td><td>7538   </td><td> 9.2250</td><td>2</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 11\n",
       "\\begin{tabular}{r|lllllllllll}\n",
       "  & PassengerId & Pclass & Name & Sex & Age & SibSp & Parch & Ticket & Fare & Embarked & reg\\_test\\\\\n",
       "  & <int> & <fct> & <chr> & <fct> & <dbl> & <int> & <int> & <chr> & <dbl> & <fct> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & 892 & 3 & Kelly, Mr. James                             & 1 & 34.5 & 0 & 0 & 330911  &  7.8292 & 1 & 0\\\\\n",
       "\t2 & 893 & 3 & Wilkes, Mrs. James (Ellen Needs)             & 0 & 47.0 & 1 & 0 & 363272  &  7.0000 & 2 & 0\\\\\n",
       "\t3 & 894 & 2 & Myles, Mr. Thomas Francis                    & 1 & 62.0 & 0 & 0 & 240276  &  9.6875 & 1 & 0\\\\\n",
       "\t4 & 895 & 3 & Wirz, Mr. Albert                             & 1 & 27.0 & 0 & 0 & 315154  &  8.6625 & 2 & 0\\\\\n",
       "\t5 & 896 & 3 & Hirvonen, Mrs. Alexander (Helga E Lindqvist) & 0 & 22.0 & 1 & 1 & 3101298 & 12.2875 & 2 & 1\\\\\n",
       "\t6 & 897 & 3 & Svensson, Mr. Johan Cervin                   & 1 & 14.0 & 0 & 0 & 7538    &  9.2250 & 2 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 11\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Pclass &lt;fct&gt; | Name &lt;chr&gt; | Sex &lt;fct&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Embarked &lt;fct&gt; | reg_test &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 892 | 3 | Kelly, Mr. James                             | 1 | 34.5 | 0 | 0 | 330911  |  7.8292 | 1 | 0 |\n",
       "| 2 | 893 | 3 | Wilkes, Mrs. James (Ellen Needs)             | 0 | 47.0 | 1 | 0 | 363272  |  7.0000 | 2 | 0 |\n",
       "| 3 | 894 | 2 | Myles, Mr. Thomas Francis                    | 1 | 62.0 | 0 | 0 | 240276  |  9.6875 | 1 | 0 |\n",
       "| 4 | 895 | 3 | Wirz, Mr. Albert                             | 1 | 27.0 | 0 | 0 | 315154  |  8.6625 | 2 | 0 |\n",
       "| 5 | 896 | 3 | Hirvonen, Mrs. Alexander (Helga E Lindqvist) | 0 | 22.0 | 1 | 1 | 3101298 | 12.2875 | 2 | 1 |\n",
       "| 6 | 897 | 3 | Svensson, Mr. Johan Cervin                   | 1 | 14.0 | 0 | 0 | 7538    |  9.2250 | 2 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Pclass Name                                         Sex Age \n",
       "1 892         3      Kelly, Mr. James                             1   34.5\n",
       "2 893         3      Wilkes, Mrs. James (Ellen Needs)             0   47.0\n",
       "3 894         2      Myles, Mr. Thomas Francis                    1   62.0\n",
       "4 895         3      Wirz, Mr. Albert                             1   27.0\n",
       "5 896         3      Hirvonen, Mrs. Alexander (Helga E Lindqvist) 0   22.0\n",
       "6 897         3      Svensson, Mr. Johan Cervin                   1   14.0\n",
       "  SibSp Parch Ticket  Fare    Embarked reg_test\n",
       "1 0     0     330911   7.8292 1        0       \n",
       "2 1     0     363272   7.0000 2        0       \n",
       "3 0     0     240276   9.6875 1        0       \n",
       "4 0     0     315154   8.6625 2        0       \n",
       "5 1     1     3101298 12.2875 2        1       \n",
       "6 0     0     7538     9.2250 2        0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I then proceed to editing the dataframe gotten\n",
    "test$reg_test <- factor(test$reg_test , level = c(FALSE , TRUE ))\n",
    "levels(test$reg_test) <- c(0,1)\n",
    "\n",
    "head(test)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "45728f28",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.528414Z",
     "iopub.status.busy": "2022-12-11T21:12:25.526587Z",
     "iopub.status.idle": "2022-12-11T21:12:25.560228Z",
     "shell.execute_reply": "2022-12-11T21:12:25.558083Z"
    },
    "papermill": {
     "duration": 0.050758,
     "end_time": "2022-12-11T21:12:25.563020",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.512262",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Survived</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>892</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>893</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>894</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>895</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>896</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>897</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & PassengerId & Survived\\\\\n",
       "  & <int> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & 892 & 0\\\\\n",
       "\t2 & 893 & 0\\\\\n",
       "\t3 & 894 & 0\\\\\n",
       "\t4 & 895 & 0\\\\\n",
       "\t5 & 896 & 1\\\\\n",
       "\t6 & 897 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Survived &lt;fct&gt; |\n",
       "|---|---|---|\n",
       "| 1 | 892 | 0 |\n",
       "| 2 | 893 | 0 |\n",
       "| 3 | 894 | 0 |\n",
       "| 4 | 895 | 0 |\n",
       "| 5 | 896 | 1 |\n",
       "| 6 | 897 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Survived\n",
       "1 892         0       \n",
       "2 893         0       \n",
       "3 894         0       \n",
       "4 895         0       \n",
       "5 896         1       \n",
       "6 897         0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I then select the variables required for the submission\n",
    "test <- test %>% select(PassengerId , Survived = reg_test)\n",
    "head(test)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "5cf48375",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-11T21:12:25.591483Z",
     "iopub.status.busy": "2022-12-11T21:12:25.589957Z",
     "iopub.status.idle": "2022-12-11T21:12:25.606489Z",
     "shell.execute_reply": "2022-12-11T21:12:25.604772Z"
    },
    "papermill": {
     "duration": 0.033956,
     "end_time": "2022-12-11T21:12:25.609427",
     "exception": false,
     "start_time": "2022-12-11T21:12:25.575471",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#I proceed to exporting the dataset for submission.\n",
    "write.csv(test,\"titanic_test.csv\", row.names = F)"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 36.980339,
   "end_time": "2022-12-11T21:12:25.742985",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-12-11T21:11:48.762646",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
