{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "f8305216",
   "metadata": {
    "papermill": {
     "duration": 0.005827,
     "end_time": "2022-12-10T13:17:22.402197",
     "exception": false,
     "start_time": "2022-12-10T13:17:22.396370",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Credit Card fraud detection ML model\n",
    "\n",
    "This is a machine learning classification model to determine whether a transaction is a fraud or not.At the end of this project,the accuracy of this model would be estimated.\n",
    "\n",
    "## Outline of the project\n",
    "* Importation of libraries and dataset\n",
    "* Data Exploration\n",
    "* Data cleaning and backup\n",
    "* Data splitting and train set and test set determination\n",
    "* Model Creation and test\n",
    "* Model efficiency test\n",
    "* Model accurarcy evaluation\n",
    "\n",
    "### Importation of libraries and dataset\n",
    "I would be using tidyverse library for this analysis,I would use cartools library also but this version of R does not support that.\n",
    "I would also be using the kaggle **Credit card dataset** , an open source dataset available for both personal and research purpose on kaggle.I begin my cleaning by converting the Class variable into a factor variable."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "01e2a76a",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:17:22.415295Z",
     "iopub.status.busy": "2022-12-10T13:17:22.413129Z",
     "iopub.status.idle": "2022-12-10T13:18:10.187871Z",
     "shell.execute_reply": "2022-12-10T13:18:10.186402Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 47.787853,
     "end_time": "2022-12-10T13:18:10.194433",
     "exception": false,
     "start_time": "2022-12-10T13:17:22.406580",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.2 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.6      \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.5 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.8      \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.10\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.1      \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.1 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.3      \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.2 \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 31</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Time</th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>⋯</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th><th scope=col>Class</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>-1.3598071</td><td>-0.07278117</td><td>2.5363467</td><td> 1.3781552</td><td>-0.33832077</td><td> 0.46238778</td><td> 0.23959855</td><td> 0.09869790</td><td> 0.3637870</td><td>⋯</td><td>-0.018306778</td><td> 0.277837576</td><td>-0.11047391</td><td> 0.06692807</td><td> 0.1285394</td><td>-0.1891148</td><td> 0.133558377</td><td>-0.02105305</td><td>149.62</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td> 1.1918571</td><td> 0.26615071</td><td>0.1664801</td><td> 0.4481541</td><td> 0.06001765</td><td>-0.08236081</td><td>-0.07880298</td><td> 0.08510165</td><td>-0.2554251</td><td>⋯</td><td>-0.225775248</td><td>-0.638671953</td><td> 0.10128802</td><td>-0.33984648</td><td> 0.1671704</td><td> 0.1258945</td><td>-0.008983099</td><td> 0.01472417</td><td>  2.69</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>-1.3583541</td><td>-1.34016307</td><td>1.7732093</td><td> 0.3797796</td><td>-0.50319813</td><td> 1.80049938</td><td> 0.79146096</td><td> 0.24767579</td><td>-1.5146543</td><td>⋯</td><td> 0.247998153</td><td> 0.771679402</td><td> 0.90941226</td><td>-0.68928096</td><td>-0.3276418</td><td>-0.1390966</td><td>-0.055352794</td><td>-0.05975184</td><td>378.66</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1</td><td>-0.9662717</td><td>-0.18522601</td><td>1.7929933</td><td>-0.8632913</td><td>-0.01030888</td><td> 1.24720317</td><td> 0.23760894</td><td> 0.37743587</td><td>-1.3870241</td><td>⋯</td><td>-0.108300452</td><td> 0.005273597</td><td>-0.19032052</td><td>-1.17557533</td><td> 0.6473760</td><td>-0.2219288</td><td> 0.062722849</td><td> 0.06145763</td><td>123.50</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>2</td><td>-1.1582331</td><td> 0.87773675</td><td>1.5487178</td><td> 0.4030339</td><td>-0.40719338</td><td> 0.09592146</td><td> 0.59294075</td><td>-0.27053268</td><td> 0.8177393</td><td>⋯</td><td>-0.009430697</td><td> 0.798278495</td><td>-0.13745808</td><td> 0.14126698</td><td>-0.2060096</td><td> 0.5022922</td><td> 0.219422230</td><td> 0.21515315</td><td> 69.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2</td><td>-0.4259659</td><td> 0.96052304</td><td>1.1411093</td><td>-0.1682521</td><td> 0.42098688</td><td>-0.02972755</td><td> 0.47620095</td><td> 0.26031433</td><td>-0.5686714</td><td>⋯</td><td>-0.208253515</td><td>-0.559824796</td><td>-0.02639767</td><td>-0.37142658</td><td>-0.2327938</td><td> 0.1059148</td><td> 0.253844225</td><td> 0.08108026</td><td>  3.67</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 31\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Time & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & ⋯ & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount & Class\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & -1.3598071 & -0.07278117 & 2.5363467 &  1.3781552 & -0.33832077 &  0.46238778 &  0.23959855 &  0.09869790 &  0.3637870 & ⋯ & -0.018306778 &  0.277837576 & -0.11047391 &  0.06692807 &  0.1285394 & -0.1891148 &  0.133558377 & -0.02105305 & 149.62 & 0\\\\\n",
       "\t2 & 0 &  1.1918571 &  0.26615071 & 0.1664801 &  0.4481541 &  0.06001765 & -0.08236081 & -0.07880298 &  0.08510165 & -0.2554251 & ⋯ & -0.225775248 & -0.638671953 &  0.10128802 & -0.33984648 &  0.1671704 &  0.1258945 & -0.008983099 &  0.01472417 &   2.69 & 0\\\\\n",
       "\t3 & 1 & -1.3583541 & -1.34016307 & 1.7732093 &  0.3797796 & -0.50319813 &  1.80049938 &  0.79146096 &  0.24767579 & -1.5146543 & ⋯ &  0.247998153 &  0.771679402 &  0.90941226 & -0.68928096 & -0.3276418 & -0.1390966 & -0.055352794 & -0.05975184 & 378.66 & 0\\\\\n",
       "\t4 & 1 & -0.9662717 & -0.18522601 & 1.7929933 & -0.8632913 & -0.01030888 &  1.24720317 &  0.23760894 &  0.37743587 & -1.3870241 & ⋯ & -0.108300452 &  0.005273597 & -0.19032052 & -1.17557533 &  0.6473760 & -0.2219288 &  0.062722849 &  0.06145763 & 123.50 & 0\\\\\n",
       "\t5 & 2 & -1.1582331 &  0.87773675 & 1.5487178 &  0.4030339 & -0.40719338 &  0.09592146 &  0.59294075 & -0.27053268 &  0.8177393 & ⋯ & -0.009430697 &  0.798278495 & -0.13745808 &  0.14126698 & -0.2060096 &  0.5022922 &  0.219422230 &  0.21515315 &  69.99 & 0\\\\\n",
       "\t6 & 2 & -0.4259659 &  0.96052304 & 1.1411093 & -0.1682521 &  0.42098688 & -0.02972755 &  0.47620095 &  0.26031433 & -0.5686714 & ⋯ & -0.208253515 & -0.559824796 & -0.02639767 & -0.37142658 & -0.2327938 &  0.1059148 &  0.253844225 &  0.08108026 &   3.67 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 31\n",
       "\n",
       "| <!--/--> | Time &lt;dbl&gt; | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | ⋯ ⋯ | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; | Class &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | -1.3598071 | -0.07278117 | 2.5363467 |  1.3781552 | -0.33832077 |  0.46238778 |  0.23959855 |  0.09869790 |  0.3637870 | ⋯ | -0.018306778 |  0.277837576 | -0.11047391 |  0.06692807 |  0.1285394 | -0.1891148 |  0.133558377 | -0.02105305 | 149.62 | 0 |\n",
       "| 2 | 0 |  1.1918571 |  0.26615071 | 0.1664801 |  0.4481541 |  0.06001765 | -0.08236081 | -0.07880298 |  0.08510165 | -0.2554251 | ⋯ | -0.225775248 | -0.638671953 |  0.10128802 | -0.33984648 |  0.1671704 |  0.1258945 | -0.008983099 |  0.01472417 |   2.69 | 0 |\n",
       "| 3 | 1 | -1.3583541 | -1.34016307 | 1.7732093 |  0.3797796 | -0.50319813 |  1.80049938 |  0.79146096 |  0.24767579 | -1.5146543 | ⋯ |  0.247998153 |  0.771679402 |  0.90941226 | -0.68928096 | -0.3276418 | -0.1390966 | -0.055352794 | -0.05975184 | 378.66 | 0 |\n",
       "| 4 | 1 | -0.9662717 | -0.18522601 | 1.7929933 | -0.8632913 | -0.01030888 |  1.24720317 |  0.23760894 |  0.37743587 | -1.3870241 | ⋯ | -0.108300452 |  0.005273597 | -0.19032052 | -1.17557533 |  0.6473760 | -0.2219288 |  0.062722849 |  0.06145763 | 123.50 | 0 |\n",
       "| 5 | 2 | -1.1582331 |  0.87773675 | 1.5487178 |  0.4030339 | -0.40719338 |  0.09592146 |  0.59294075 | -0.27053268 |  0.8177393 | ⋯ | -0.009430697 |  0.798278495 | -0.13745808 |  0.14126698 | -0.2060096 |  0.5022922 |  0.219422230 |  0.21515315 |  69.99 | 0 |\n",
       "| 6 | 2 | -0.4259659 |  0.96052304 | 1.1411093 | -0.1682521 |  0.42098688 | -0.02972755 |  0.47620095 |  0.26031433 | -0.5686714 | ⋯ | -0.208253515 | -0.559824796 | -0.02639767 | -0.37142658 | -0.2327938 |  0.1059148 |  0.253844225 |  0.08108026 |   3.67 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Time V1         V2          V3        V4         V5          V6         \n",
       "1 0    -1.3598071 -0.07278117 2.5363467  1.3781552 -0.33832077  0.46238778\n",
       "2 0     1.1918571  0.26615071 0.1664801  0.4481541  0.06001765 -0.08236081\n",
       "3 1    -1.3583541 -1.34016307 1.7732093  0.3797796 -0.50319813  1.80049938\n",
       "4 1    -0.9662717 -0.18522601 1.7929933 -0.8632913 -0.01030888  1.24720317\n",
       "5 2    -1.1582331  0.87773675 1.5487178  0.4030339 -0.40719338  0.09592146\n",
       "6 2    -0.4259659  0.96052304 1.1411093 -0.1682521  0.42098688 -0.02972755\n",
       "  V7          V8          V9         ⋯ V21          V22          V23        \n",
       "1  0.23959855  0.09869790  0.3637870 ⋯ -0.018306778  0.277837576 -0.11047391\n",
       "2 -0.07880298  0.08510165 -0.2554251 ⋯ -0.225775248 -0.638671953  0.10128802\n",
       "3  0.79146096  0.24767579 -1.5146543 ⋯  0.247998153  0.771679402  0.90941226\n",
       "4  0.23760894  0.37743587 -1.3870241 ⋯ -0.108300452  0.005273597 -0.19032052\n",
       "5  0.59294075 -0.27053268  0.8177393 ⋯ -0.009430697  0.798278495 -0.13745808\n",
       "6  0.47620095  0.26031433 -0.5686714 ⋯ -0.208253515 -0.559824796 -0.02639767\n",
       "  V24         V25        V26        V27          V28         Amount Class\n",
       "1  0.06692807  0.1285394 -0.1891148  0.133558377 -0.02105305 149.62 0    \n",
       "2 -0.33984648  0.1671704  0.1258945 -0.008983099  0.01472417   2.69 0    \n",
       "3 -0.68928096 -0.3276418 -0.1390966 -0.055352794 -0.05975184 378.66 0    \n",
       "4 -1.17557533  0.6473760 -0.2219288  0.062722849  0.06145763 123.50 0    \n",
       "5  0.14126698 -0.2060096  0.5022922  0.219422230  0.21515315  69.99 0    \n",
       "6 -0.37142658 -0.2327938  0.1059148  0.253844225  0.08108026   3.67 0    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I would be making use of various libraries for this project\n",
    "library(tidyverse)\n",
    "library(tidyr)\n",
    "library(dplyr)\n",
    "library(ggplot2)\n",
    "\n",
    "#import our credit card fraud dataset(an open source dataset)\n",
    "credit_card <- read.csv(\"/kaggle/input/creditcardfraud/creditcard.csv\")\n",
    "\n",
    "#converting our dependent variable(Class) for this model into factpor\n",
    "credit_card$Class <- factor(credit_card$Class , levels = c(0,1))\n",
    "head(credit_card)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "461399d6",
   "metadata": {
    "papermill": {
     "duration": 0.004559,
     "end_time": "2022-12-10T13:18:10.203450",
     "exception": false,
     "start_time": "2022-12-10T13:18:10.198891",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Data Exploration\n",
    "I would go on to carry out basic exploration on my dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "ba5e31bf",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:10.240667Z",
     "iopub.status.busy": "2022-12-10T13:18:10.215065Z",
     "iopub.status.idle": "2022-12-10T13:18:11.433171Z",
     "shell.execute_reply": "2022-12-10T13:18:11.431354Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 1.227356,
     "end_time": "2022-12-10T13:18:11.435527",
     "exception": false,
     "start_time": "2022-12-10T13:18:10.208171",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "      Time              V1                  V2                  V3          \n",
       " Min.   :     0   Min.   :-56.40751   Min.   :-72.71573   Min.   :-48.3256  \n",
       " 1st Qu.: 54202   1st Qu.: -0.92037   1st Qu.: -0.59855   1st Qu.: -0.8904  \n",
       " Median : 84692   Median :  0.01811   Median :  0.06549   Median :  0.1799  \n",
       " Mean   : 94814   Mean   :  0.00000   Mean   :  0.00000   Mean   :  0.0000  \n",
       " 3rd Qu.:139320   3rd Qu.:  1.31564   3rd Qu.:  0.80372   3rd Qu.:  1.0272  \n",
       " Max.   :172792   Max.   :  2.45493   Max.   : 22.05773   Max.   :  9.3826  \n",
       "       V4                 V5                   V6                 V7          \n",
       " Min.   :-5.68317   Min.   :-113.74331   Min.   :-26.1605   Min.   :-43.5572  \n",
       " 1st Qu.:-0.84864   1st Qu.:  -0.69160   1st Qu.: -0.7683   1st Qu.: -0.5541  \n",
       " Median :-0.01985   Median :  -0.05434   Median : -0.2742   Median :  0.0401  \n",
       " Mean   : 0.00000   Mean   :   0.00000   Mean   :  0.0000   Mean   :  0.0000  \n",
       " 3rd Qu.: 0.74334   3rd Qu.:   0.61193   3rd Qu.:  0.3986   3rd Qu.:  0.5704  \n",
       " Max.   :16.87534   Max.   :  34.80167   Max.   : 73.3016   Max.   :120.5895  \n",
       "       V8                  V9                 V10                 V11          \n",
       " Min.   :-73.21672   Min.   :-13.43407   Min.   :-24.58826   Min.   :-4.79747  \n",
       " 1st Qu.: -0.20863   1st Qu.: -0.64310   1st Qu.: -0.53543   1st Qu.:-0.76249  \n",
       " Median :  0.02236   Median : -0.05143   Median : -0.09292   Median :-0.03276  \n",
       " Mean   :  0.00000   Mean   :  0.00000   Mean   :  0.00000   Mean   : 0.00000  \n",
       " 3rd Qu.:  0.32735   3rd Qu.:  0.59714   3rd Qu.:  0.45392   3rd Qu.: 0.73959  \n",
       " Max.   : 20.00721   Max.   : 15.59500   Max.   : 23.74514   Max.   :12.01891  \n",
       "      V12                V13                V14                V15          \n",
       " Min.   :-18.6837   Min.   :-5.79188   Min.   :-19.2143   Min.   :-4.49894  \n",
       " 1st Qu.: -0.4056   1st Qu.:-0.64854   1st Qu.: -0.4256   1st Qu.:-0.58288  \n",
       " Median :  0.1400   Median :-0.01357   Median :  0.0506   Median : 0.04807  \n",
       " Mean   :  0.0000   Mean   : 0.00000   Mean   :  0.0000   Mean   : 0.00000  \n",
       " 3rd Qu.:  0.6182   3rd Qu.: 0.66251   3rd Qu.:  0.4931   3rd Qu.: 0.64882  \n",
       " Max.   :  7.8484   Max.   : 7.12688   Max.   : 10.5268   Max.   : 8.87774  \n",
       "      V16                 V17                 V18           \n",
       " Min.   :-14.12985   Min.   :-25.16280   Min.   :-9.498746  \n",
       " 1st Qu.: -0.46804   1st Qu.: -0.48375   1st Qu.:-0.498850  \n",
       " Median :  0.06641   Median : -0.06568   Median :-0.003636  \n",
       " Mean   :  0.00000   Mean   :  0.00000   Mean   : 0.000000  \n",
       " 3rd Qu.:  0.52330   3rd Qu.:  0.39968   3rd Qu.: 0.500807  \n",
       " Max.   : 17.31511   Max.   :  9.25353   Max.   : 5.041069  \n",
       "      V19                 V20                 V21           \n",
       " Min.   :-7.213527   Min.   :-54.49772   Min.   :-34.83038  \n",
       " 1st Qu.:-0.456299   1st Qu.: -0.21172   1st Qu.: -0.22839  \n",
       " Median : 0.003735   Median : -0.06248   Median : -0.02945  \n",
       " Mean   : 0.000000   Mean   :  0.00000   Mean   :  0.00000  \n",
       " 3rd Qu.: 0.458949   3rd Qu.:  0.13304   3rd Qu.:  0.18638  \n",
       " Max.   : 5.591971   Max.   : 39.42090   Max.   : 27.20284  \n",
       "      V22                  V23                 V24          \n",
       " Min.   :-10.933144   Min.   :-44.80774   Min.   :-2.83663  \n",
       " 1st Qu.: -0.542350   1st Qu.: -0.16185   1st Qu.:-0.35459  \n",
       " Median :  0.006782   Median : -0.01119   Median : 0.04098  \n",
       " Mean   :  0.000000   Mean   :  0.00000   Mean   : 0.00000  \n",
       " 3rd Qu.:  0.528554   3rd Qu.:  0.14764   3rd Qu.: 0.43953  \n",
       " Max.   : 10.503090   Max.   : 22.52841   Max.   : 4.58455  \n",
       "      V25                 V26                V27            \n",
       " Min.   :-10.29540   Min.   :-2.60455   Min.   :-22.565679  \n",
       " 1st Qu.: -0.31715   1st Qu.:-0.32698   1st Qu.: -0.070840  \n",
       " Median :  0.01659   Median :-0.05214   Median :  0.001342  \n",
       " Mean   :  0.00000   Mean   : 0.00000   Mean   :  0.000000  \n",
       " 3rd Qu.:  0.35072   3rd Qu.: 0.24095   3rd Qu.:  0.091045  \n",
       " Max.   :  7.51959   Max.   : 3.51735   Max.   : 31.612198  \n",
       "      V28                Amount         Class     \n",
       " Min.   :-15.43008   Min.   :    0.00   0:284315  \n",
       " 1st Qu.: -0.05296   1st Qu.:    5.60   1:   492  \n",
       " Median :  0.01124   Median :   22.00             \n",
       " Mean   :  0.00000   Mean   :   88.35             \n",
       " 3rd Qu.:  0.07828   3rd Qu.:   77.17             \n",
       " Max.   : 33.84781   Max.   :25691.16             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "          0           1 \n",
       "0.998272514 0.001727486 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#The summary of the datset is looked into to find information\n",
    "summary(credit_card)\n",
    "sum(is.na(credit_card))\n",
    "\n",
    "#A tabel of the values for our class variable is made\n",
    "table_class <- table(credit_card$Class)\n",
    "prop.table(table_class)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "539d86d2",
   "metadata": {
    "papermill": {
     "duration": 0.004916,
     "end_time": "2022-12-10T13:18:11.445486",
     "exception": false,
     "start_time": "2022-12-10T13:18:11.440570",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Data Cleaning and Backup\n",
    "I go on to make a backup dataset before i begin cleaning and analysis of the dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "ed331808",
   "metadata": {
    "_kg_hide-output": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:11.457739Z",
     "iopub.status.busy": "2022-12-10T13:18:11.456572Z",
     "iopub.status.idle": "2022-12-10T13:18:11.503697Z",
     "shell.execute_reply": "2022-12-10T13:18:11.501946Z"
    },
    "papermill": {
     "duration": 0.055586,
     "end_time": "2022-12-10T13:18:11.505769",
     "exception": false,
     "start_time": "2022-12-10T13:18:11.450183",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#The need to prepare a backup dataset in case of unexpected errors during analysis and data preparation\n",
    "credit_card1 <- credit_card %>% select(1:31)\n",
    "\n",
    "#This is the datset we would be making use of for this modeling\n",
    "credit_card2 <- credit_card1 %>% select(-1)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "d61bab05",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:11.519167Z",
     "iopub.status.busy": "2022-12-10T13:18:11.517771Z",
     "iopub.status.idle": "2022-12-10T13:18:11.570097Z",
     "shell.execute_reply": "2022-12-10T13:18:11.568593Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.060943,
     "end_time": "2022-12-10T13:18:11.571935",
     "exception": false,
     "start_time": "2022-12-10T13:18:11.510992",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t284807 obs. of  31 variables:\n",
      " $ Time  : num  0 0 1 1 2 2 4 7 7 9 ...\n",
      " $ V1    : num  -1.36 1.192 -1.358 -0.966 -1.158 ...\n",
      " $ V2    : num  -0.0728 0.2662 -1.3402 -0.1852 0.8777 ...\n",
      " $ V3    : num  2.536 0.166 1.773 1.793 1.549 ...\n",
      " $ V4    : num  1.378 0.448 0.38 -0.863 0.403 ...\n",
      " $ V5    : num  -0.3383 0.06 -0.5032 -0.0103 -0.4072 ...\n",
      " $ V6    : num  0.4624 -0.0824 1.8005 1.2472 0.0959 ...\n",
      " $ V7    : num  0.2396 -0.0788 0.7915 0.2376 0.5929 ...\n",
      " $ V8    : num  0.0987 0.0851 0.2477 0.3774 -0.2705 ...\n",
      " $ V9    : num  0.364 -0.255 -1.515 -1.387 0.818 ...\n",
      " $ V10   : num  0.0908 -0.167 0.2076 -0.055 0.7531 ...\n",
      " $ V11   : num  -0.552 1.613 0.625 -0.226 -0.823 ...\n",
      " $ V12   : num  -0.6178 1.0652 0.0661 0.1782 0.5382 ...\n",
      " $ V13   : num  -0.991 0.489 0.717 0.508 1.346 ...\n",
      " $ V14   : num  -0.311 -0.144 -0.166 -0.288 -1.12 ...\n",
      " $ V15   : num  1.468 0.636 2.346 -0.631 0.175 ...\n",
      " $ V16   : num  -0.47 0.464 -2.89 -1.06 -0.451 ...\n",
      " $ V17   : num  0.208 -0.115 1.11 -0.684 -0.237 ...\n",
      " $ V18   : num  0.0258 -0.1834 -0.1214 1.9658 -0.0382 ...\n",
      " $ V19   : num  0.404 -0.146 -2.262 -1.233 0.803 ...\n",
      " $ V20   : num  0.2514 -0.0691 0.525 -0.208 0.4085 ...\n",
      " $ V21   : num  -0.01831 -0.22578 0.248 -0.1083 -0.00943 ...\n",
      " $ V22   : num  0.27784 -0.63867 0.77168 0.00527 0.79828 ...\n",
      " $ V23   : num  -0.11 0.101 0.909 -0.19 -0.137 ...\n",
      " $ V24   : num  0.0669 -0.3398 -0.6893 -1.1756 0.1413 ...\n",
      " $ V25   : num  0.129 0.167 -0.328 0.647 -0.206 ...\n",
      " $ V26   : num  -0.189 0.126 -0.139 -0.222 0.502 ...\n",
      " $ V27   : num  0.13356 -0.00898 -0.05535 0.06272 0.21942 ...\n",
      " $ V28   : num  -0.0211 0.0147 -0.0598 0.0615 0.2152 ...\n",
      " $ Amount: num  149.62 2.69 378.66 123.5 69.99 ...\n",
      " $ Class : Factor w/ 2 levels \"0\",\"1\": 1 1 1 1 1 1 1 1 1 1 ...\n",
      "'data.frame':\t284807 obs. of  30 variables:\n",
      " $ V1    : num  -1.36 1.192 -1.358 -0.966 -1.158 ...\n",
      " $ V2    : num  -0.0728 0.2662 -1.3402 -0.1852 0.8777 ...\n",
      " $ V3    : num  2.536 0.166 1.773 1.793 1.549 ...\n",
      " $ V4    : num  1.378 0.448 0.38 -0.863 0.403 ...\n",
      " $ V5    : num  -0.3383 0.06 -0.5032 -0.0103 -0.4072 ...\n",
      " $ V6    : num  0.4624 -0.0824 1.8005 1.2472 0.0959 ...\n",
      " $ V7    : num  0.2396 -0.0788 0.7915 0.2376 0.5929 ...\n",
      " $ V8    : num  0.0987 0.0851 0.2477 0.3774 -0.2705 ...\n",
      " $ V9    : num  0.364 -0.255 -1.515 -1.387 0.818 ...\n",
      " $ V10   : num  0.0908 -0.167 0.2076 -0.055 0.7531 ...\n",
      " $ V11   : num  -0.552 1.613 0.625 -0.226 -0.823 ...\n",
      " $ V12   : num  -0.6178 1.0652 0.0661 0.1782 0.5382 ...\n",
      " $ V13   : num  -0.991 0.489 0.717 0.508 1.346 ...\n",
      " $ V14   : num  -0.311 -0.144 -0.166 -0.288 -1.12 ...\n",
      " $ V15   : num  1.468 0.636 2.346 -0.631 0.175 ...\n",
      " $ V16   : num  -0.47 0.464 -2.89 -1.06 -0.451 ...\n",
      " $ V17   : num  0.208 -0.115 1.11 -0.684 -0.237 ...\n",
      " $ V18   : num  0.0258 -0.1834 -0.1214 1.9658 -0.0382 ...\n",
      " $ V19   : num  0.404 -0.146 -2.262 -1.233 0.803 ...\n",
      " $ V20   : num  0.2514 -0.0691 0.525 -0.208 0.4085 ...\n",
      " $ V21   : num  -0.01831 -0.22578 0.248 -0.1083 -0.00943 ...\n",
      " $ V22   : num  0.27784 -0.63867 0.77168 0.00527 0.79828 ...\n",
      " $ V23   : num  -0.11 0.101 0.909 -0.19 -0.137 ...\n",
      " $ V24   : num  0.0669 -0.3398 -0.6893 -1.1756 0.1413 ...\n",
      " $ V25   : num  0.129 0.167 -0.328 0.647 -0.206 ...\n",
      " $ V26   : num  -0.189 0.126 -0.139 -0.222 0.502 ...\n",
      " $ V27   : num  0.13356 -0.00898 -0.05535 0.06272 0.21942 ...\n",
      " $ V28   : num  -0.0211 0.0147 -0.0598 0.0615 0.2152 ...\n",
      " $ Amount: num  149.62 2.69 378.66 123.5 69.99 ...\n",
      " $ Class : Factor w/ 2 levels \"0\",\"1\": 1 1 1 1 1 1 1 1 1 1 ...\n"
     ]
    }
   ],
   "source": [
    "str(credit_card1)\n",
    "str(credit_card2)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0ed2ff4a",
   "metadata": {
    "papermill": {
     "duration": 0.005092,
     "end_time": "2022-12-10T13:18:11.582104",
     "exception": false,
     "start_time": "2022-12-10T13:18:11.577012",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "From the analysis above,we confirm the dataset is clean and usable after dropping the **time** variable(as it is not relevant to our model).\n",
    "\n",
    "\n",
    "### Data Splitting and train set and test set determination\n",
    "We go ahead to split our data into the train and test set as we get ready for model creation. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "e9b66358",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:11.594906Z",
     "iopub.status.busy": "2022-12-10T13:18:11.593582Z",
     "iopub.status.idle": "2022-12-10T13:18:33.639224Z",
     "shell.execute_reply": "2022-12-10T13:18:33.637633Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 22.054503,
     "end_time": "2022-12-10T13:18:33.641453",
     "exception": false,
     "start_time": "2022-12-10T13:18:11.586950",
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
      "\n"
     ]
    }
   ],
   "source": [
    "#I would go ahead to install the caTools package for our model creation\n",
    "install.packages(\"caTools\")\n",
    "library(caTools)\n",
    "\n",
    "#I would go ahead to split the dataset in the 80:20 ratio for train:test\n",
    "split_data <- sample.split(credit_card2 , SplitRatio = 0.80)\n",
    "\n",
    "#Declaring my train and test data into objects\n",
    "train_dataset <- subset(credit_card2 , split_data == TRUE)\n",
    "test_dataset <- subset(credit_card2 , split_data == FALSE)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "660fb763",
   "metadata": {
    "papermill": {
     "duration": 0.004981,
     "end_time": "2022-12-10T13:18:33.652024",
     "exception": false,
     "start_time": "2022-12-10T13:18:33.647043",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Model creation and testing\n",
    "I would go on to create the model for regression(logistic regression)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "788869d9",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:33.664836Z",
     "iopub.status.busy": "2022-12-10T13:18:33.663610Z",
     "iopub.status.idle": "2022-12-10T13:18:37.366354Z",
     "shell.execute_reply": "2022-12-10T13:18:37.364621Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 3.711506,
     "end_time": "2022-12-10T13:18:37.368509",
     "exception": false,
     "start_time": "2022-12-10T13:18:33.657003",
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
       "glm(formula = Class ~ ., family = \"binomial\", data = train_dataset)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-4.9189  -0.0289  -0.0189  -0.0115   4.6274  \n",
       "\n",
       "Coefficients:\n",
       "              Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept) -8.8189051  0.1816681 -48.544  < 2e-16 ***\n",
       "V1           0.0754282  0.0472245   1.597 0.110215    \n",
       "V2           0.0045819  0.0686681   0.067 0.946801    \n",
       "V3           0.0358682  0.0517108   0.694 0.487913    \n",
       "V4           0.6849099  0.0872923   7.846 4.29e-15 ***\n",
       "V5           0.0883126  0.0784786   1.125 0.260459    \n",
       "V6          -0.1167975  0.0865750  -1.349 0.177308    \n",
       "V7          -0.0854241  0.0805905  -1.060 0.289155    \n",
       "V8          -0.1941860  0.0348454  -5.573 2.51e-08 ***\n",
       "V9          -0.2167286  0.1330106  -1.629 0.103227    \n",
       "V10         -0.8977388  0.1163260  -7.717 1.19e-14 ***\n",
       "V11         -0.0473806  0.0866466  -0.547 0.584499    \n",
       "V12          0.1143912  0.0996682   1.148 0.251084    \n",
       "V13         -0.3940757  0.0948349  -4.155 3.25e-05 ***\n",
       "V14         -0.6157513  0.0710544  -8.666  < 2e-16 ***\n",
       "V15         -0.0282638  0.0953332  -0.296 0.766869    \n",
       "V16         -0.0917548  0.1576156  -0.582 0.560471    \n",
       "V17         -0.0003072  0.0778754  -0.004 0.996853    \n",
       "V18         -0.1151791  0.1559763  -0.738 0.460247    \n",
       "V19          0.1919581  0.1133342   1.694 0.090316 .  \n",
       "V20         -0.3706587  0.1037098  -3.574 0.000352 ***\n",
       "V21          0.4386599  0.0694392   6.317 2.66e-10 ***\n",
       "V22          0.7065565  0.1484811   4.759 1.95e-06 ***\n",
       "V23         -0.1553678  0.0688647  -2.256 0.024062 *  \n",
       "V24          0.1609269  0.1676430   0.960 0.337087    \n",
       "V25          0.0342002  0.1465529   0.233 0.815478    \n",
       "V26          0.1099137  0.2069842   0.531 0.595402    \n",
       "V27         -0.7691433  0.1476447  -5.209 1.89e-07 ***\n",
       "V28         -0.2410799  0.1111534  -2.169 0.030091 *  \n",
       "Amount       0.0007054  0.0004642   1.520 0.128631    \n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 5963.9  on 227845  degrees of freedom\n",
       "Residual deviance: 1760.0  on 227816  degrees of freedom\n",
       "AIC: 1820\n",
       "\n",
       "Number of Fisher Scoring iterations: 12\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# I would be making use of a regression model as I am not making a classification right now\n",
    "model <- glm(Class ~. ,train_dataset ,family = \"binomial\")\n",
    "summary(model)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a2aa4a2e",
   "metadata": {
    "papermill": {
     "duration": 0.006051,
     "end_time": "2022-12-10T13:18:37.381986",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.375935",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Model testing\n",
    "I would go ahead to test my model on some observations as the first step of testing.I start by making smaller chunks of my data so I can feed it into my model"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "36dcc313",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:37.395885Z",
     "iopub.status.busy": "2022-12-10T13:18:37.394571Z",
     "iopub.status.idle": "2022-12-10T13:18:37.534530Z",
     "shell.execute_reply": "2022-12-10T13:18:37.533273Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.14979,
     "end_time": "2022-12-10T13:18:37.537215",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.387425",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 56961 × 30</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>V10</th><th scope=col>⋯</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th><th scope=col>Class</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>-1.35980713</td><td>-0.07278117</td><td> 2.53634674</td><td> 1.37815522</td><td>-0.338320770</td><td> 0.46238778</td><td> 0.239598554</td><td> 0.09869790</td><td> 0.36378697</td><td> 0.09079417</td><td>⋯</td><td>-0.01830678</td><td> 0.27783758</td><td>-0.110473910</td><td> 0.066928075</td><td> 0.12853936</td><td>-0.18911484</td><td> 0.133558377</td><td>-0.021053053</td><td>149.62</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>-1.35835406</td><td>-1.34016307</td><td> 1.77320934</td><td> 0.37977959</td><td>-0.503198133</td><td> 1.80049938</td><td> 0.791460956</td><td> 0.24767579</td><td>-1.51465432</td><td> 0.20764287</td><td>⋯</td><td> 0.24799815</td><td> 0.77167940</td><td> 0.909412262</td><td>-0.689280956</td><td>-0.32764183</td><td>-0.13909657</td><td>-0.055352794</td><td>-0.059751841</td><td>378.66</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>14</th><td> 1.06937359</td><td> 0.28772213</td><td> 0.82861273</td><td> 2.71252043</td><td>-0.178398016</td><td> 0.33754373</td><td>-0.096716862</td><td> 0.11598174</td><td>-0.22108257</td><td> 0.46023044</td><td>⋯</td><td>-0.03687553</td><td> 0.07441240</td><td>-0.071407433</td><td> 0.104743753</td><td> 0.54826473</td><td> 0.10409415</td><td> 0.021491058</td><td> 0.021293311</td><td> 27.50</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>20</th><td> 1.49293598</td><td>-1.02934573</td><td> 0.45479473</td><td>-1.43802588</td><td>-1.555434101</td><td>-0.72096115</td><td>-1.080664130</td><td>-0.05312712</td><td>-1.97868160</td><td> 1.63807604</td><td>⋯</td><td>-0.17764985</td><td>-0.17507381</td><td> 0.040002219</td><td> 0.295813863</td><td> 0.33293060</td><td>-0.22038485</td><td> 0.022298436</td><td> 0.007602256</td><td>  5.00</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>24</th><td> 0.24749113</td><td> 0.27766563</td><td> 1.18547084</td><td>-0.09260255</td><td>-1.314393979</td><td>-0.15011600</td><td>-0.946364950</td><td>-1.61793505</td><td> 1.54407140</td><td>-0.82988060</td><td>⋯</td><td> 1.65018036</td><td> 0.20045409</td><td>-0.185352508</td><td> 0.423073148</td><td> 0.82059126</td><td>-0.22763186</td><td> 0.336634447</td><td> 0.250475352</td><td> 22.75</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>29</th><td>-0.41428881</td><td> 0.90543732</td><td> 1.72745294</td><td> 1.47347127</td><td> 0.007442741</td><td>-0.20033068</td><td> 0.740228319</td><td>-0.02924740</td><td>-0.59339202</td><td>-0.34618823</td><td>⋯</td><td> 0.07723743</td><td> 0.45733060</td><td>-0.038499725</td><td> 0.642521903</td><td>-0.18389134</td><td>-0.27746402</td><td> 0.182687486</td><td> 0.152664645</td><td> 33.00</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>31</th><td> 1.23742903</td><td> 0.06104258</td><td> 0.38052588</td><td> 0.76156411</td><td>-0.359770710</td><td>-0.49408415</td><td> 0.006494218</td><td>-0.13386238</td><td> 0.43880974</td><td>-0.20735805</td><td>⋯</td><td>-0.24568250</td><td>-0.53090026</td><td>-0.044265397</td><td> 0.079168029</td><td> 0.50913569</td><td> 0.28885783</td><td>-0.022704982</td><td> 0.011836231</td><td> 17.28</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>33</th><td>-0.52991228</td><td> 0.87389158</td><td> 1.34724733</td><td> 0.14545668</td><td> 0.414208858</td><td> 0.10022309</td><td> 0.711206083</td><td> 0.17606596</td><td>-0.28671693</td><td>-0.48468768</td><td>⋯</td><td> 0.04694907</td><td> 0.20810486</td><td>-0.185548347</td><td> 0.001030660</td><td> 0.09881570</td><td>-0.55290360</td><td>-0.073288084</td><td> 0.023307045</td><td>  6.14</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>44</th><td>-0.93573151</td><td> 0.17041577</td><td> 2.74626127</td><td>-1.07796491</td><td>-0.305594036</td><td> 0.01157704</td><td>-0.296178451</td><td> 0.40277557</td><td>-0.04047175</td><td>-0.85204598</td><td>⋯</td><td> 0.40121202</td><td> 1.06486425</td><td>-0.158325436</td><td> 0.295505486</td><td>-0.25936965</td><td> 0.75419472</td><td> 0.046663770</td><td> 0.093947918</td><td>  9.10</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>50</th><td>-1.06323568</td><td> 1.41819063</td><td> 1.08667286</td><td> 1.24143960</td><td> 0.002306126</td><td> 0.04590158</td><td> 0.514120897</td><td> 0.24125240</td><td>-0.15449995</td><td> 0.28067262</td><td>⋯</td><td>-0.05722847</td><td> 0.31415300</td><td>-0.129862928</td><td> 0.114283708</td><td>-0.02781248</td><td>-0.25993702</td><td> 0.118753640</td><td>-0.008956298</td><td> 20.22</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>54</th><td> 1.09552461</td><td>-0.11608535</td><td> 1.39791192</td><td> 1.49754690</td><td>-1.049123999</td><td> 0.07283853</td><td>-0.723802080</td><td> 0.28753247</td><td> 0.99632681</td><td>-0.14914465</td><td>⋯</td><td>-0.03323417</td><td> 0.09326188</td><td> 0.089498395</td><td> 0.361261298</td><td> 0.25096295</td><td>-0.37827998</td><td> 0.081023900</td><td> 0.034226938</td><td>  2.09</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>59</th><td> 1.11069200</td><td> 0.08194190</td><td> 0.40606304</td><td> 1.29074038</td><td>-0.169813148</td><td> 0.12095538</td><td>-0.080845205</td><td> 0.17437308</td><td> 0.15207073</td><td> 0.06526672</td><td>⋯</td><td>-0.05602398</td><td>-0.01160309</td><td>-0.070482892</td><td> 0.004345191</td><td> 0.60392864</td><td>-0.32742445</td><td> 0.029889689</td><td> 0.004944296</td><td> 13.84</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>61</th><td> 0.98606333</td><td>-0.20296459</td><td>-0.49276815</td><td> 0.40769127</td><td> 0.305660256</td><td>-0.23052918</td><td> 0.585028086</td><td>-0.20822459</td><td>-0.24750345</td><td>-0.19225313</td><td>⋯</td><td>-0.30587393</td><td>-1.21655527</td><td>-0.077601526</td><td>-0.741340788</td><td> 0.28688112</td><td> 0.20034670</td><td>-0.075203351</td><td> 0.027271219</td><td>169.05</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>63</th><td> 1.14552439</td><td> 0.57506797</td><td> 0.19400846</td><td> 2.59819174</td><td>-0.092210023</td><td>-1.04442958</td><td> 0.531587593</td><td>-0.24188813</td><td>-0.89628717</td><td> 0.75795233</td><td>⋯</td><td> 0.01110633</td><td>-0.11970310</td><td>-0.076509528</td><td> 0.691320431</td><td> 0.63398398</td><td> 0.04874127</td><td>-0.053191942</td><td> 0.016251499</td><td> 34.13</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>74</th><td>-0.58062897</td><td> 0.48268393</td><td> 1.33312308</td><td>-0.25308002</td><td>-0.028468940</td><td>-0.51916570</td><td> 0.503249461</td><td> 0.11777348</td><td> 0.11711224</td><td>-0.42048754</td><td>⋯</td><td>-0.04214233</td><td>-0.14870728</td><td> 0.001451165</td><td> 0.302764487</td><td>-0.68071420</td><td>-0.01555392</td><td>-0.006307004</td><td> 0.164222205</td><td> 21.66</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>80</th><td>-0.67170855</td><td> 0.59450259</td><td> 0.21641594</td><td>-0.86731064</td><td> 2.966908301</td><td> 3.63249487</td><td> 0.563295075</td><td> 0.67302560</td><td>-0.18876614</td><td>-0.40437829</td><td>⋯</td><td>-0.13644097</td><td>-0.30036203</td><td>-0.331691623</td><td> 0.996382471</td><td> 0.50246949</td><td>-0.51804305</td><td>-0.208275755</td><td>-0.116048406</td><td> 14.80</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>84</th><td>-1.19896767</td><td>-1.47410047</td><td> 1.84032599</td><td>-4.51582435</td><td> 0.327567428</td><td>-0.17446928</td><td> 0.959725705</td><td>-1.02645623</td><td> 1.70043458</td><td>-0.07894176</td><td>⋯</td><td>-0.45316942</td><td> 0.33461404</td><td>-0.364541412</td><td>-0.310185782</td><td>-0.30259949</td><td>-1.24392415</td><td>-1.123456545</td><td>-0.734351086</td><td> 89.17</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>89</th><td> 0.08699619</td><td>-0.05198874</td><td>-0.49788244</td><td>-3.15190786</td><td> 2.558400362</td><td> 2.79667097</td><td> 0.470283271</td><td> 0.26533280</td><td> 0.91951346</td><td>-0.73558569</td><td>⋯</td><td>-0.23942558</td><td>-0.43734214</td><td> 0.018425768</td><td> 1.013037763</td><td>-0.25892656</td><td>-0.29318925</td><td>-0.394955581</td><td>-0.435995593</td><td> 10.84</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>91</th><td> 0.92102402</td><td>-0.16244686</td><td>-0.09433137</td><td> 0.47408393</td><td>-0.021485961</td><td>-0.39750631</td><td> 0.482642979</td><td>-0.11749597</td><td>-0.57783603</td><td>-0.01860714</td><td>⋯</td><td>-0.20938111</td><td>-0.93010730</td><td> 0.028509911</td><td> 0.032682009</td><td> 0.15513050</td><td> 0.13325047</td><td>-0.073534231</td><td> 0.022349145</td><td>149.90</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>93</th><td> 1.10702938</td><td> 0.21644100</td><td> 0.53837815</td><td> 1.47639799</td><td>-0.251941920</td><td>-0.34067971</td><td> 0.154091745</td><td>-0.08650255</td><td> 0.14442020</td><td>-0.15737463</td><td>⋯</td><td>-0.06003745</td><td> 0.05988412</td><td>-0.047526366</td><td> 0.443992419</td><td> 0.64029576</td><td>-0.33765713</td><td> 0.042108484</td><td> 0.024264710</td><td> 26.72</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>104</th><td>-0.60802693</td><td> 0.30669360</td><td> 1.47300415</td><td> 1.19112725</td><td> 0.021264671</td><td> 0.88844249</td><td> 1.190491174</td><td> 0.04214674</td><td>-0.44642561</td><td>-0.08038612</td><td>⋯</td><td> 0.04650638</td><td> 0.16516250</td><td> 0.063974176</td><td>-0.333791686</td><td> 0.13177582</td><td>-0.21769193</td><td>-0.082183353</td><td>-0.116730187</td><td>168.56</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>110</th><td> 1.23904805</td><td> 0.29328442</td><td> 0.08647196</td><td> 1.17827736</td><td> 0.373343851</td><td> 0.32559601</td><td> 0.119318979</td><td>-0.02547625</td><td> 0.17321136</td><td>-0.15418618</td><td>⋯</td><td>-0.14813619</td><td>-0.11189263</td><td>-0.173207278</td><td>-0.714729129</td><td> 0.81735994</td><td>-0.26384275</td><td> 0.047776818</td><td> 0.008735382</td><td>  1.00</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>114</th><td> 1.03837033</td><td> 0.12748613</td><td> 0.18445589</td><td> 1.10994979</td><td> 0.441698900</td><td> 0.94528253</td><td>-0.036714604</td><td> 0.35099500</td><td> 0.11894954</td><td>-0.24328924</td><td>⋯</td><td> 0.10251980</td><td> 0.60508853</td><td> 0.023092156</td><td>-0.626462661</td><td> 0.47912027</td><td>-0.16693684</td><td> 0.081246718</td><td> 0.001191576</td><td>  1.18</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>119</th><td>-0.99717576</td><td> 0.22836530</td><td> 1.71533994</td><td>-0.42006677</td><td> 0.560837845</td><td> 0.56472505</td><td> 0.846046550</td><td> 0.19749082</td><td>-0.09720188</td><td>-0.43934683</td><td>⋯</td><td>-0.07024076</td><td> 0.01544495</td><td> 0.072651066</td><td>-0.272271751</td><td>-0.08768151</td><td> 0.13813212</td><td> 0.125901816</td><td>-0.063022320</td><td> 86.43</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>121</th><td>-1.18595403</td><td>-0.21880844</td><td> 1.10100483</td><td>-1.40699713</td><td> 1.261783204</td><td>-0.33770907</td><td> 1.191747221</td><td>-0.42738311</td><td> 0.27667889</td><td>-0.21539920</td><td>⋯</td><td>-0.36283038</td><td>-0.41881699</td><td> 0.521401264</td><td>-0.922427393</td><td>-0.13984027</td><td> 0.70978702</td><td>-0.076248716</td><td>-0.383942454</td><td> 49.95</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>123</th><td>-0.62247837</td><td> 0.01488140</td><td> 1.05248874</td><td>-1.64457383</td><td>-0.538265319</td><td>-0.83552821</td><td> 0.517233526</td><td>-1.10596237</td><td>-1.31174062</td><td> 0.57746838</td><td>⋯</td><td> 0.41881889</td><td>-0.76212234</td><td>-0.098939524</td><td> 0.502972747</td><td>-0.65525128</td><td> 0.74341921</td><td>-0.020568090</td><td>-0.118060229</td><td>104.94</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>134</th><td>-0.83320034</td><td> 0.77878712</td><td> 2.61923666</td><td> 2.61286413</td><td>-0.516937610</td><td> 0.55834601</td><td> 0.316871358</td><td> 0.20664711</td><td>-0.73859916</td><td> 0.21434036</td><td>⋯</td><td> 0.18871128</td><td> 0.67860587</td><td>-0.133148108</td><td> 0.636175834</td><td> 0.30932909</td><td> 0.27214995</td><td>-0.078460786</td><td> 0.007343970</td><td> 79.91</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>140</th><td>-4.25759744</td><td> 1.64948917</td><td>-1.59124167</td><td>-1.37431677</td><td>-1.180135992</td><td>-0.33103953</td><td>-0.117991556</td><td> 1.59203218</td><td> 0.41599568</td><td> 0.15916328</td><td>⋯</td><td>-0.45256781</td><td>-0.67170252</td><td> 0.001422276</td><td>-0.876376518</td><td> 0.07009822</td><td> 0.72958230</td><td>-0.002942371</td><td>-0.481496958</td><td>124.67</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>144</th><td>-0.58985594</td><td> 0.93306987</td><td>-0.26807262</td><td> 0.12524463</td><td> 2.396991769</td><td> 3.87794520</td><td> 0.189985383</td><td> 0.96038859</td><td>-0.23000013</td><td> 0.29511018</td><td>⋯</td><td>-0.15439733</td><td>-0.17483415</td><td>-0.201368584</td><td> 1.013438753</td><td> 0.19441248</td><td>-0.23176497</td><td> 0.541146887</td><td> 0.255373813</td><td> 37.13</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>149</th><td>-0.23841096</td><td> 0.50926277</td><td> 1.95200070</td><td> 0.77906595</td><td>-0.378940130</td><td> 0.25113656</td><td>-0.072412057</td><td> 0.22875486</td><td> 0.21089959</td><td>-0.37381413</td><td>⋯</td><td> 0.21744861</td><td> 0.90377655</td><td>-0.121348660</td><td> 0.141224740</td><td>-0.61385385</td><td> 0.57592018</td><td> 0.193591769</td><td> 0.165131782</td><td>  2.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>⋮</th><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋱</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><th scope=row>284660</th><td>-2.73434961</td><td> 0.11540489</td><td>-1.2469853</td><td>-1.47163002</td><td> 1.55866703</td><td>-1.55262259</td><td> 1.30500687</td><td> 0.42144619</td><td>-1.4754347</td><td>-1.55812166</td><td>⋯</td><td> 0.50875065</td><td> 0.7511849</td><td>-0.90376604</td><td> 0.897164402</td><td> 1.70441566</td><td> 0.31367118</td><td>-0.441428119</td><td>-0.3719709701</td><td> 76.00</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284664</th><td> 1.95828670</td><td>-0.19585812</td><td>-1.4940227</td><td> 0.73901804</td><td> 0.23412703</td><td>-0.24025555</td><td>-0.03799524</td><td>-0.08961327</td><td> 1.1589403</td><td>-0.67241546</td><td>⋯</td><td>-0.44519214</td><td>-0.9758691</td><td> 0.22621134</td><td> 0.414537226</td><td>-0.11517106</td><td> 0.25815004</td><td>-0.039310151</td><td>-0.0230666104</td><td> 43.09</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284669</th><td> 1.78632585</td><td>-0.38973948</td><td>-0.8171634</td><td> 1.24780987</td><td>-0.18497019</td><td>-0.13274526</td><td>-0.16544779</td><td> 0.03382061</td><td> 0.5580742</td><td> 0.35001747</td><td>⋯</td><td> 0.12358473</td><td> 0.2865092</td><td> 0.05019139</td><td>-0.433841099</td><td>-0.05495557</td><td>-0.65718230</td><td> 0.014365254</td><td>-0.0384192895</td><td> 91.20</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284671</th><td>-2.31575258</td><td> 2.38563309</td><td>-1.5588933</td><td>-0.70903002</td><td>-1.09513469</td><td>-1.15874632</td><td>-0.59970512</td><td> 1.72289014</td><td>-0.1028035</td><td> 0.11617584</td><td>⋯</td><td>-0.16722135</td><td>-0.6421290</td><td> 0.32071139</td><td> 0.033782329</td><td>-0.25815727</td><td> 0.14470589</td><td> 0.166016716</td><td> 0.0713901681</td><td>  9.23</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284673</th><td>-1.10764203</td><td> 1.18869065</td><td> 1.1266165</td><td> 0.19100946</td><td>-0.74887520</td><td> 1.02372920</td><td>-1.58512073</td><td>-1.45742017</td><td> 0.6025471</td><td>-0.37015363</td><td>⋯</td><td> 2.68485853</td><td> 0.3083459</td><td> 0.25811637</td><td>-0.548003064</td><td>-0.49351902</td><td>-0.62846740</td><td> 0.150128974</td><td> 0.0169003567</td><td>  0.01</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284684</th><td> 1.91547450</td><td>-0.21701885</td><td>-0.5217310</td><td> 1.27442970</td><td>-0.12471489</td><td> 0.35164029</td><td>-0.50227602</td><td> 0.17047028</td><td> 0.7736684</td><td> 0.28049952</td><td>⋯</td><td> 0.25994415</td><td> 1.0137523</td><td> 0.06077960</td><td> 0.726831402</td><td> 0.15469028</td><td>-0.48058840</td><td> 0.047439265</td><td>-0.0427860134</td><td>  5.90</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284690</th><td> 1.83399957</td><td>-0.73608994</td><td>-0.4832008</td><td> 0.12739185</td><td>-0.05889954</td><td> 1.49223731</td><td>-1.07443219</td><td> 0.61566139</td><td> 1.1601771</td><td> 0.05998520</td><td>⋯</td><td> 0.26233422</td><td> 1.0143474</td><td> 0.19802203</td><td>-1.467513360</td><td>-0.51458209</td><td> 0.67757363</td><td> 0.023793747</td><td>-0.0743059426</td><td> 11.50</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284694</th><td>-0.97324533</td><td> 0.36545922</td><td> 0.5448808</td><td>-0.01874973</td><td> 0.82395984</td><td>-1.83056864</td><td> 1.63271812</td><td>-0.26393083</td><td>-0.3430312</td><td>-0.89443803</td><td>⋯</td><td> 0.22175065</td><td> 0.3531573</td><td> 0.03799850</td><td> 0.798246404</td><td> 0.26183734</td><td>-0.82084813</td><td> 0.052708986</td><td> 0.1613924941</td><td> 89.90</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284699</th><td>-0.85768766</td><td> 0.29094518</td><td>-2.3914479</td><td>-0.31545743</td><td>-0.01445453</td><td>-1.76559457</td><td> 2.67177910</td><td>-0.51125746</td><td>-0.7401753</td><td>-0.38463957</td><td>⋯</td><td> 0.48405029</td><td> 1.8265749</td><td> 0.86239538</td><td> 0.586088667</td><td>-1.03614482</td><td> 0.65976541</td><td> 0.436364652</td><td> 0.1734915778</td><td>307.88</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284701</th><td> 2.04587290</td><td>-1.20696822</td><td> 0.7489072</td><td>-0.52448183</td><td>-2.29578294</td><td>-0.93093602</td><td>-1.64916725</td><td> 0.03042932</td><td> 0.6227105</td><td> 0.69067084</td><td>⋯</td><td> 0.48248785</td><td> 1.4767459</td><td> 0.30705800</td><td> 0.958799368</td><td>-0.54933445</td><td>-0.14799662</td><td> 0.055248229</td><td>-0.0222821093</td><td> 12.50</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284703</th><td>-0.48167169</td><td> 1.57929701</td><td>-1.2841543</td><td>-0.08352434</td><td> 0.09781538</td><td>-1.42121628</td><td> 0.26549044</td><td> 0.52814006</td><td>-0.3079063</td><td>-1.33194283</td><td>⋯</td><td> 0.38898120</td><td> 0.9310191</td><td>-0.11444752</td><td>-0.196205076</td><td>-0.35053241</td><td>-0.15616843</td><td>-0.242230952</td><td>-0.0002897593</td><td>  2.32</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284714</th><td>-3.72045714</td><td> 3.87948948</td><td>-2.5607745</td><td>-2.17737109</td><td> 0.49587187</td><td>-1.24778498</td><td> 1.33762244</td><td> 0.01426936</td><td> 2.7051184</td><td> 4.83813357</td><td>⋯</td><td>-0.23563364</td><td> 0.5799722</td><td>-0.01714725</td><td> 0.647609435</td><td> 0.40523853</td><td> 0.05962486</td><td> 1.596482026</td><td> 0.7178274277</td><td>  0.92</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284720</th><td>-1.27726167</td><td> 1.22042487</td><td> 0.2424964</td><td>-0.56952018</td><td> 0.27986040</td><td> 1.33838434</td><td> 0.85088010</td><td>-1.29462688</td><td> 0.1873760</td><td>-1.75908295</td><td>⋯</td><td> 1.30275708</td><td>-0.8364154</td><td>-0.07372184</td><td>-1.206611639</td><td> 0.42980652</td><td> 0.23948759</td><td> 0.246823802</td><td> 0.0297780973</td><td>157.04</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284724</th><td>-0.27332940</td><td> 1.11880233</td><td>-0.3827244</td><td>-0.61196073</td><td> 1.51940058</td><td>-0.84813023</td><td> 1.79453551</td><td>-0.59567201</td><td>-0.4420765</td><td>-0.89288725</td><td>⋯</td><td>-0.05592114</td><td> 0.1171239</td><td>-0.33439925</td><td> 0.642114091</td><td>-0.01082399</td><td> 0.43940482</td><td>-0.198835175</td><td>-0.0652823222</td><td> 36.25</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284729</th><td>-2.96924965</td><td> 3.21685096</td><td>-2.8730019</td><td>-0.62884007</td><td>-1.00936620</td><td>-1.23940561</td><td>-0.86851715</td><td> 2.09513920</td><td> 0.2989027</td><td>-0.10101491</td><td>⋯</td><td>-0.31438538</td><td>-1.0509027</td><td> 0.38790206</td><td> 0.598871193</td><td>-0.02031615</td><td> 0.14691903</td><td> 0.232855823</td><td> 0.1221755696</td><td>  9.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284731</th><td> 2.03772756</td><td>-0.07283719</td><td>-1.0719067</td><td> 0.41398555</td><td>-0.10525421</td><td>-1.12207508</td><td> 0.19257610</td><td>-0.32098730</td><td> 0.5131737</td><td> 0.05597329</td><td>⋯</td><td>-0.27645573</td><td>-0.6658015</td><td> 0.33766632</td><td>-0.008123892</td><td>-0.31067768</td><td> 0.19961535</td><td>-0.067991400</td><td>-0.0587028632</td><td>  9.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284733</th><td> 1.07617508</td><td>-3.11635274</td><td>-2.0514389</td><td>-0.95318890</td><td>-1.54483805</td><td>-1.12464466</td><td> 0.38557049</td><td>-0.69801421</td><td>-1.8294009</td><td> 1.26914864</td><td>⋯</td><td> 0.10485277</td><td>-0.5982427</td><td>-0.34316379</td><td> 0.088299202</td><td>-0.26765760</td><td>-0.31365149</td><td>-0.132090610</td><td> 0.0560289943</td><td>664.60</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284744</th><td> 2.11292937</td><td> 0.17357338</td><td>-2.1880480</td><td> 0.30135015</td><td> 0.70001190</td><td>-0.86026004</td><td> 0.23827512</td><td>-0.29605747</td><td> 0.6810697</td><td>-0.51822985</td><td>⋯</td><td> 0.12766273</td><td> 0.5412904</td><td>-0.14684851</td><td>-1.139951806</td><td> 0.37117618</td><td>-0.03319877</td><td>-0.001178497</td><td>-0.0396175018</td><td>  7.80</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284750</th><td>-0.21487626</td><td> 0.79257770</td><td>-0.2651947</td><td>-0.43617685</td><td> 1.23013411</td><td> 0.36894379</td><td> 0.74154409</td><td> 0.26387522</td><td> 0.1617620</td><td>-1.11646674</td><td>⋯</td><td> 0.17793628</td><td> 0.9807293</td><td>-0.20082830</td><td>-0.986811153</td><td>-0.16634203</td><td> 0.77545824</td><td> 0.321541751</td><td> 0.1149591324</td><td>  7.88</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284754</th><td> 1.46573688</td><td>-0.61804658</td><td>-2.8513909</td><td> 1.42528201</td><td> 0.89389301</td><td>-0.95832535</td><td> 1.50807441</td><td>-0.62569138</td><td>-0.3698240</td><td> 0.21829981</td><td>⋯</td><td> 0.50042609</td><td> 0.8704913</td><td>-0.49540999</td><td> 0.676929397</td><td> 0.78768759</td><td>-0.25491793</td><td>-0.117199621</td><td>-0.0147369315</td><td>337.54</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284759</th><td> 1.91137703</td><td> 1.22089632</td><td>-1.6651273</td><td> 4.14879803</td><td> 1.02944172</td><td>-0.72760990</td><td> 0.50074482</td><td>-0.19861407</td><td>-1.1405646</td><td> 0.29564853</td><td>⋯</td><td>-0.42911569</td><td>-1.1841976</td><td> 0.28866057</td><td>-0.418322696</td><td>-0.22272861</td><td>-0.33582969</td><td>-0.001157886</td><td> 0.0175559411</td><td>  6.75</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284761</th><td>-0.65739261</td><td> 1.03898723</td><td>-1.4981620</td><td>-1.88937444</td><td> 2.81951976</td><td> 3.33392537</td><td> 0.28756918</td><td> 0.95860408</td><td> 0.4087111</td><td> 0.54103675</td><td>⋯</td><td>-0.35733049</td><td>-0.7835532</td><td> 0.13847084</td><td> 0.677220906</td><td>-0.30627850</td><td> 0.17572426</td><td> 0.580689093</td><td> 0.2810843630</td><td>  1.78</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284763</th><td>-1.19165359</td><td>-0.44122592</td><td> 1.7297472</td><td> 0.33737269</td><td> 1.71898922</td><td> 5.49309244</td><td>-1.27310072</td><td> 1.68639380</td><td> 1.1268067</td><td>-0.67617863</td><td>⋯</td><td> 0.14931139</td><td> 0.6989382</td><td>-0.19688478</td><td> 0.731485389</td><td> 0.66739129</td><td>-0.13334680</td><td> 0.417417507</td><td> 0.1619667492</td><td> 79.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284774</th><td>-0.06613576</td><td> 0.99629639</td><td>-0.9185644</td><td>-0.92324161</td><td> 1.25652164</td><td> 0.04744553</td><td> 0.70581951</td><td> 0.23232998</td><td> 0.2131572</td><td>-0.31204764</td><td>⋯</td><td>-0.39721044</td><td>-1.0380994</td><td> 0.00212035</td><td>-0.512741023</td><td>-0.34972124</td><td> 0.16869287</td><td> 0.316673794</td><td> 0.1200654056</td><td>  3.57</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284780</th><td> 1.97517827</td><td>-0.61624401</td><td>-2.6282950</td><td>-0.40624559</td><td> 2.32780433</td><td> 3.66474012</td><td>-0.53329691</td><td> 0.84293703</td><td> 1.1287979</td><td>-0.22074419</td><td>⋯</td><td> 0.08604338</td><td> 0.5436127</td><td>-0.03212929</td><td> 0.768379191</td><td> 0.47768760</td><td>-0.03183282</td><td> 0.014150872</td><td>-0.0665416968</td><td> 25.00</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284784</th><td>-1.79609202</td><td> 1.92917844</td><td>-2.8284173</td><td>-1.68984379</td><td> 2.19957203</td><td> 3.12373190</td><td>-0.27071406</td><td> 1.65749525</td><td> 0.4658038</td><td> 0.83293091</td><td>⋯</td><td> 0.27117008</td><td> 1.1457502</td><td> 0.08478275</td><td> 0.721269433</td><td>-0.52990598</td><td>-0.24011733</td><td> 0.129125565</td><td>-0.0806203045</td><td> 11.46</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284789</th><td> 2.00741803</td><td>-0.28023497</td><td>-0.2081132</td><td> 0.33526094</td><td>-0.71579823</td><td>-0.75137308</td><td>-0.45897191</td><td>-0.14014038</td><td> 0.9599713</td><td>-0.02828406</td><td>⋯</td><td>-0.20826014</td><td>-0.4303466</td><td> 0.41676533</td><td> 0.064819455</td><td>-0.60833652</td><td> 0.26843624</td><td>-0.028068547</td><td>-0.0413674217</td><td>  3.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284791</th><td>-0.51551285</td><td> 0.97195037</td><td>-1.0145802</td><td>-0.67703687</td><td> 0.91243000</td><td>-0.31618711</td><td> 0.39613749</td><td> 0.53236435</td><td>-0.2246059</td><td>-0.75336512</td><td>⋯</td><td>-0.28030189</td><td>-0.8499192</td><td> 0.30024545</td><td> 0.000606787</td><td>-0.37637895</td><td> 0.12866028</td><td>-0.015204853</td><td>-0.0214855616</td><td>  9.81</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284793</th><td>-0.72412286</td><td> 1.48521564</td><td>-1.1322181</td><td>-0.60719026</td><td> 0.70949876</td><td>-0.48263811</td><td> 0.54839312</td><td> 0.34300332</td><td>-0.2263229</td><td>-0.34813371</td><td>⋯</td><td> 0.41462062</td><td> 1.3075111</td><td>-0.05954451</td><td> 0.242668830</td><td>-0.66542446</td><td>-0.26986930</td><td>-0.170579064</td><td>-0.0306924981</td><td>  3.99</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>284804</th><td>-0.73278867</td><td>-0.05508049</td><td> 2.0350297</td><td>-0.73858858</td><td> 0.86822940</td><td> 1.05841527</td><td> 0.02432970</td><td> 0.29486870</td><td> 0.5848000</td><td>-0.97592606</td><td>⋯</td><td> 0.21420534</td><td> 0.9243836</td><td> 0.01246304</td><td>-1.016225669</td><td>-0.60662399</td><td>-0.39525507</td><td> 0.068472470</td><td>-0.0535273892</td><td> 24.79</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 56961 × 30\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & V10 & ⋯ & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount & Class\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & -1.35980713 & -0.07278117 &  2.53634674 &  1.37815522 & -0.338320770 &  0.46238778 &  0.239598554 &  0.09869790 &  0.36378697 &  0.09079417 & ⋯ & -0.01830678 &  0.27783758 & -0.110473910 &  0.066928075 &  0.12853936 & -0.18911484 &  0.133558377 & -0.021053053 & 149.62 & 0\\\\\n",
       "\t3 & -1.35835406 & -1.34016307 &  1.77320934 &  0.37977959 & -0.503198133 &  1.80049938 &  0.791460956 &  0.24767579 & -1.51465432 &  0.20764287 & ⋯ &  0.24799815 &  0.77167940 &  0.909412262 & -0.689280956 & -0.32764183 & -0.13909657 & -0.055352794 & -0.059751841 & 378.66 & 0\\\\\n",
       "\t14 &  1.06937359 &  0.28772213 &  0.82861273 &  2.71252043 & -0.178398016 &  0.33754373 & -0.096716862 &  0.11598174 & -0.22108257 &  0.46023044 & ⋯ & -0.03687553 &  0.07441240 & -0.071407433 &  0.104743753 &  0.54826473 &  0.10409415 &  0.021491058 &  0.021293311 &  27.50 & 0\\\\\n",
       "\t20 &  1.49293598 & -1.02934573 &  0.45479473 & -1.43802588 & -1.555434101 & -0.72096115 & -1.080664130 & -0.05312712 & -1.97868160 &  1.63807604 & ⋯ & -0.17764985 & -0.17507381 &  0.040002219 &  0.295813863 &  0.33293060 & -0.22038485 &  0.022298436 &  0.007602256 &   5.00 & 0\\\\\n",
       "\t24 &  0.24749113 &  0.27766563 &  1.18547084 & -0.09260255 & -1.314393979 & -0.15011600 & -0.946364950 & -1.61793505 &  1.54407140 & -0.82988060 & ⋯ &  1.65018036 &  0.20045409 & -0.185352508 &  0.423073148 &  0.82059126 & -0.22763186 &  0.336634447 &  0.250475352 &  22.75 & 0\\\\\n",
       "\t29 & -0.41428881 &  0.90543732 &  1.72745294 &  1.47347127 &  0.007442741 & -0.20033068 &  0.740228319 & -0.02924740 & -0.59339202 & -0.34618823 & ⋯ &  0.07723743 &  0.45733060 & -0.038499725 &  0.642521903 & -0.18389134 & -0.27746402 &  0.182687486 &  0.152664645 &  33.00 & 0\\\\\n",
       "\t31 &  1.23742903 &  0.06104258 &  0.38052588 &  0.76156411 & -0.359770710 & -0.49408415 &  0.006494218 & -0.13386238 &  0.43880974 & -0.20735805 & ⋯ & -0.24568250 & -0.53090026 & -0.044265397 &  0.079168029 &  0.50913569 &  0.28885783 & -0.022704982 &  0.011836231 &  17.28 & 0\\\\\n",
       "\t33 & -0.52991228 &  0.87389158 &  1.34724733 &  0.14545668 &  0.414208858 &  0.10022309 &  0.711206083 &  0.17606596 & -0.28671693 & -0.48468768 & ⋯ &  0.04694907 &  0.20810486 & -0.185548347 &  0.001030660 &  0.09881570 & -0.55290360 & -0.073288084 &  0.023307045 &   6.14 & 0\\\\\n",
       "\t44 & -0.93573151 &  0.17041577 &  2.74626127 & -1.07796491 & -0.305594036 &  0.01157704 & -0.296178451 &  0.40277557 & -0.04047175 & -0.85204598 & ⋯ &  0.40121202 &  1.06486425 & -0.158325436 &  0.295505486 & -0.25936965 &  0.75419472 &  0.046663770 &  0.093947918 &   9.10 & 0\\\\\n",
       "\t50 & -1.06323568 &  1.41819063 &  1.08667286 &  1.24143960 &  0.002306126 &  0.04590158 &  0.514120897 &  0.24125240 & -0.15449995 &  0.28067262 & ⋯ & -0.05722847 &  0.31415300 & -0.129862928 &  0.114283708 & -0.02781248 & -0.25993702 &  0.118753640 & -0.008956298 &  20.22 & 0\\\\\n",
       "\t54 &  1.09552461 & -0.11608535 &  1.39791192 &  1.49754690 & -1.049123999 &  0.07283853 & -0.723802080 &  0.28753247 &  0.99632681 & -0.14914465 & ⋯ & -0.03323417 &  0.09326188 &  0.089498395 &  0.361261298 &  0.25096295 & -0.37827998 &  0.081023900 &  0.034226938 &   2.09 & 0\\\\\n",
       "\t59 &  1.11069200 &  0.08194190 &  0.40606304 &  1.29074038 & -0.169813148 &  0.12095538 & -0.080845205 &  0.17437308 &  0.15207073 &  0.06526672 & ⋯ & -0.05602398 & -0.01160309 & -0.070482892 &  0.004345191 &  0.60392864 & -0.32742445 &  0.029889689 &  0.004944296 &  13.84 & 0\\\\\n",
       "\t61 &  0.98606333 & -0.20296459 & -0.49276815 &  0.40769127 &  0.305660256 & -0.23052918 &  0.585028086 & -0.20822459 & -0.24750345 & -0.19225313 & ⋯ & -0.30587393 & -1.21655527 & -0.077601526 & -0.741340788 &  0.28688112 &  0.20034670 & -0.075203351 &  0.027271219 & 169.05 & 0\\\\\n",
       "\t63 &  1.14552439 &  0.57506797 &  0.19400846 &  2.59819174 & -0.092210023 & -1.04442958 &  0.531587593 & -0.24188813 & -0.89628717 &  0.75795233 & ⋯ &  0.01110633 & -0.11970310 & -0.076509528 &  0.691320431 &  0.63398398 &  0.04874127 & -0.053191942 &  0.016251499 &  34.13 & 0\\\\\n",
       "\t74 & -0.58062897 &  0.48268393 &  1.33312308 & -0.25308002 & -0.028468940 & -0.51916570 &  0.503249461 &  0.11777348 &  0.11711224 & -0.42048754 & ⋯ & -0.04214233 & -0.14870728 &  0.001451165 &  0.302764487 & -0.68071420 & -0.01555392 & -0.006307004 &  0.164222205 &  21.66 & 0\\\\\n",
       "\t80 & -0.67170855 &  0.59450259 &  0.21641594 & -0.86731064 &  2.966908301 &  3.63249487 &  0.563295075 &  0.67302560 & -0.18876614 & -0.40437829 & ⋯ & -0.13644097 & -0.30036203 & -0.331691623 &  0.996382471 &  0.50246949 & -0.51804305 & -0.208275755 & -0.116048406 &  14.80 & 0\\\\\n",
       "\t84 & -1.19896767 & -1.47410047 &  1.84032599 & -4.51582435 &  0.327567428 & -0.17446928 &  0.959725705 & -1.02645623 &  1.70043458 & -0.07894176 & ⋯ & -0.45316942 &  0.33461404 & -0.364541412 & -0.310185782 & -0.30259949 & -1.24392415 & -1.123456545 & -0.734351086 &  89.17 & 0\\\\\n",
       "\t89 &  0.08699619 & -0.05198874 & -0.49788244 & -3.15190786 &  2.558400362 &  2.79667097 &  0.470283271 &  0.26533280 &  0.91951346 & -0.73558569 & ⋯ & -0.23942558 & -0.43734214 &  0.018425768 &  1.013037763 & -0.25892656 & -0.29318925 & -0.394955581 & -0.435995593 &  10.84 & 0\\\\\n",
       "\t91 &  0.92102402 & -0.16244686 & -0.09433137 &  0.47408393 & -0.021485961 & -0.39750631 &  0.482642979 & -0.11749597 & -0.57783603 & -0.01860714 & ⋯ & -0.20938111 & -0.93010730 &  0.028509911 &  0.032682009 &  0.15513050 &  0.13325047 & -0.073534231 &  0.022349145 & 149.90 & 0\\\\\n",
       "\t93 &  1.10702938 &  0.21644100 &  0.53837815 &  1.47639799 & -0.251941920 & -0.34067971 &  0.154091745 & -0.08650255 &  0.14442020 & -0.15737463 & ⋯ & -0.06003745 &  0.05988412 & -0.047526366 &  0.443992419 &  0.64029576 & -0.33765713 &  0.042108484 &  0.024264710 &  26.72 & 0\\\\\n",
       "\t104 & -0.60802693 &  0.30669360 &  1.47300415 &  1.19112725 &  0.021264671 &  0.88844249 &  1.190491174 &  0.04214674 & -0.44642561 & -0.08038612 & ⋯ &  0.04650638 &  0.16516250 &  0.063974176 & -0.333791686 &  0.13177582 & -0.21769193 & -0.082183353 & -0.116730187 & 168.56 & 0\\\\\n",
       "\t110 &  1.23904805 &  0.29328442 &  0.08647196 &  1.17827736 &  0.373343851 &  0.32559601 &  0.119318979 & -0.02547625 &  0.17321136 & -0.15418618 & ⋯ & -0.14813619 & -0.11189263 & -0.173207278 & -0.714729129 &  0.81735994 & -0.26384275 &  0.047776818 &  0.008735382 &   1.00 & 0\\\\\n",
       "\t114 &  1.03837033 &  0.12748613 &  0.18445589 &  1.10994979 &  0.441698900 &  0.94528253 & -0.036714604 &  0.35099500 &  0.11894954 & -0.24328924 & ⋯ &  0.10251980 &  0.60508853 &  0.023092156 & -0.626462661 &  0.47912027 & -0.16693684 &  0.081246718 &  0.001191576 &   1.18 & 0\\\\\n",
       "\t119 & -0.99717576 &  0.22836530 &  1.71533994 & -0.42006677 &  0.560837845 &  0.56472505 &  0.846046550 &  0.19749082 & -0.09720188 & -0.43934683 & ⋯ & -0.07024076 &  0.01544495 &  0.072651066 & -0.272271751 & -0.08768151 &  0.13813212 &  0.125901816 & -0.063022320 &  86.43 & 0\\\\\n",
       "\t121 & -1.18595403 & -0.21880844 &  1.10100483 & -1.40699713 &  1.261783204 & -0.33770907 &  1.191747221 & -0.42738311 &  0.27667889 & -0.21539920 & ⋯ & -0.36283038 & -0.41881699 &  0.521401264 & -0.922427393 & -0.13984027 &  0.70978702 & -0.076248716 & -0.383942454 &  49.95 & 0\\\\\n",
       "\t123 & -0.62247837 &  0.01488140 &  1.05248874 & -1.64457383 & -0.538265319 & -0.83552821 &  0.517233526 & -1.10596237 & -1.31174062 &  0.57746838 & ⋯ &  0.41881889 & -0.76212234 & -0.098939524 &  0.502972747 & -0.65525128 &  0.74341921 & -0.020568090 & -0.118060229 & 104.94 & 0\\\\\n",
       "\t134 & -0.83320034 &  0.77878712 &  2.61923666 &  2.61286413 & -0.516937610 &  0.55834601 &  0.316871358 &  0.20664711 & -0.73859916 &  0.21434036 & ⋯ &  0.18871128 &  0.67860587 & -0.133148108 &  0.636175834 &  0.30932909 &  0.27214995 & -0.078460786 &  0.007343970 &  79.91 & 0\\\\\n",
       "\t140 & -4.25759744 &  1.64948917 & -1.59124167 & -1.37431677 & -1.180135992 & -0.33103953 & -0.117991556 &  1.59203218 &  0.41599568 &  0.15916328 & ⋯ & -0.45256781 & -0.67170252 &  0.001422276 & -0.876376518 &  0.07009822 &  0.72958230 & -0.002942371 & -0.481496958 & 124.67 & 0\\\\\n",
       "\t144 & -0.58985594 &  0.93306987 & -0.26807262 &  0.12524463 &  2.396991769 &  3.87794520 &  0.189985383 &  0.96038859 & -0.23000013 &  0.29511018 & ⋯ & -0.15439733 & -0.17483415 & -0.201368584 &  1.013438753 &  0.19441248 & -0.23176497 &  0.541146887 &  0.255373813 &  37.13 & 0\\\\\n",
       "\t149 & -0.23841096 &  0.50926277 &  1.95200070 &  0.77906595 & -0.378940130 &  0.25113656 & -0.072412057 &  0.22875486 &  0.21089959 & -0.37381413 & ⋯ &  0.21744861 &  0.90377655 & -0.121348660 &  0.141224740 & -0.61385385 &  0.57592018 &  0.193591769 &  0.165131782 &   2.99 & 0\\\\\n",
       "\t⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋱ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t284660 & -2.73434961 &  0.11540489 & -1.2469853 & -1.47163002 &  1.55866703 & -1.55262259 &  1.30500687 &  0.42144619 & -1.4754347 & -1.55812166 & ⋯ &  0.50875065 &  0.7511849 & -0.90376604 &  0.897164402 &  1.70441566 &  0.31367118 & -0.441428119 & -0.3719709701 &  76.00 & 0\\\\\n",
       "\t284664 &  1.95828670 & -0.19585812 & -1.4940227 &  0.73901804 &  0.23412703 & -0.24025555 & -0.03799524 & -0.08961327 &  1.1589403 & -0.67241546 & ⋯ & -0.44519214 & -0.9758691 &  0.22621134 &  0.414537226 & -0.11517106 &  0.25815004 & -0.039310151 & -0.0230666104 &  43.09 & 0\\\\\n",
       "\t284669 &  1.78632585 & -0.38973948 & -0.8171634 &  1.24780987 & -0.18497019 & -0.13274526 & -0.16544779 &  0.03382061 &  0.5580742 &  0.35001747 & ⋯ &  0.12358473 &  0.2865092 &  0.05019139 & -0.433841099 & -0.05495557 & -0.65718230 &  0.014365254 & -0.0384192895 &  91.20 & 0\\\\\n",
       "\t284671 & -2.31575258 &  2.38563309 & -1.5588933 & -0.70903002 & -1.09513469 & -1.15874632 & -0.59970512 &  1.72289014 & -0.1028035 &  0.11617584 & ⋯ & -0.16722135 & -0.6421290 &  0.32071139 &  0.033782329 & -0.25815727 &  0.14470589 &  0.166016716 &  0.0713901681 &   9.23 & 0\\\\\n",
       "\t284673 & -1.10764203 &  1.18869065 &  1.1266165 &  0.19100946 & -0.74887520 &  1.02372920 & -1.58512073 & -1.45742017 &  0.6025471 & -0.37015363 & ⋯ &  2.68485853 &  0.3083459 &  0.25811637 & -0.548003064 & -0.49351902 & -0.62846740 &  0.150128974 &  0.0169003567 &   0.01 & 0\\\\\n",
       "\t284684 &  1.91547450 & -0.21701885 & -0.5217310 &  1.27442970 & -0.12471489 &  0.35164029 & -0.50227602 &  0.17047028 &  0.7736684 &  0.28049952 & ⋯ &  0.25994415 &  1.0137523 &  0.06077960 &  0.726831402 &  0.15469028 & -0.48058840 &  0.047439265 & -0.0427860134 &   5.90 & 0\\\\\n",
       "\t284690 &  1.83399957 & -0.73608994 & -0.4832008 &  0.12739185 & -0.05889954 &  1.49223731 & -1.07443219 &  0.61566139 &  1.1601771 &  0.05998520 & ⋯ &  0.26233422 &  1.0143474 &  0.19802203 & -1.467513360 & -0.51458209 &  0.67757363 &  0.023793747 & -0.0743059426 &  11.50 & 0\\\\\n",
       "\t284694 & -0.97324533 &  0.36545922 &  0.5448808 & -0.01874973 &  0.82395984 & -1.83056864 &  1.63271812 & -0.26393083 & -0.3430312 & -0.89443803 & ⋯ &  0.22175065 &  0.3531573 &  0.03799850 &  0.798246404 &  0.26183734 & -0.82084813 &  0.052708986 &  0.1613924941 &  89.90 & 0\\\\\n",
       "\t284699 & -0.85768766 &  0.29094518 & -2.3914479 & -0.31545743 & -0.01445453 & -1.76559457 &  2.67177910 & -0.51125746 & -0.7401753 & -0.38463957 & ⋯ &  0.48405029 &  1.8265749 &  0.86239538 &  0.586088667 & -1.03614482 &  0.65976541 &  0.436364652 &  0.1734915778 & 307.88 & 0\\\\\n",
       "\t284701 &  2.04587290 & -1.20696822 &  0.7489072 & -0.52448183 & -2.29578294 & -0.93093602 & -1.64916725 &  0.03042932 &  0.6227105 &  0.69067084 & ⋯ &  0.48248785 &  1.4767459 &  0.30705800 &  0.958799368 & -0.54933445 & -0.14799662 &  0.055248229 & -0.0222821093 &  12.50 & 0\\\\\n",
       "\t284703 & -0.48167169 &  1.57929701 & -1.2841543 & -0.08352434 &  0.09781538 & -1.42121628 &  0.26549044 &  0.52814006 & -0.3079063 & -1.33194283 & ⋯ &  0.38898120 &  0.9310191 & -0.11444752 & -0.196205076 & -0.35053241 & -0.15616843 & -0.242230952 & -0.0002897593 &   2.32 & 0\\\\\n",
       "\t284714 & -3.72045714 &  3.87948948 & -2.5607745 & -2.17737109 &  0.49587187 & -1.24778498 &  1.33762244 &  0.01426936 &  2.7051184 &  4.83813357 & ⋯ & -0.23563364 &  0.5799722 & -0.01714725 &  0.647609435 &  0.40523853 &  0.05962486 &  1.596482026 &  0.7178274277 &   0.92 & 0\\\\\n",
       "\t284720 & -1.27726167 &  1.22042487 &  0.2424964 & -0.56952018 &  0.27986040 &  1.33838434 &  0.85088010 & -1.29462688 &  0.1873760 & -1.75908295 & ⋯ &  1.30275708 & -0.8364154 & -0.07372184 & -1.206611639 &  0.42980652 &  0.23948759 &  0.246823802 &  0.0297780973 & 157.04 & 0\\\\\n",
       "\t284724 & -0.27332940 &  1.11880233 & -0.3827244 & -0.61196073 &  1.51940058 & -0.84813023 &  1.79453551 & -0.59567201 & -0.4420765 & -0.89288725 & ⋯ & -0.05592114 &  0.1171239 & -0.33439925 &  0.642114091 & -0.01082399 &  0.43940482 & -0.198835175 & -0.0652823222 &  36.25 & 0\\\\\n",
       "\t284729 & -2.96924965 &  3.21685096 & -2.8730019 & -0.62884007 & -1.00936620 & -1.23940561 & -0.86851715 &  2.09513920 &  0.2989027 & -0.10101491 & ⋯ & -0.31438538 & -1.0509027 &  0.38790206 &  0.598871193 & -0.02031615 &  0.14691903 &  0.232855823 &  0.1221755696 &   9.99 & 0\\\\\n",
       "\t284731 &  2.03772756 & -0.07283719 & -1.0719067 &  0.41398555 & -0.10525421 & -1.12207508 &  0.19257610 & -0.32098730 &  0.5131737 &  0.05597329 & ⋯ & -0.27645573 & -0.6658015 &  0.33766632 & -0.008123892 & -0.31067768 &  0.19961535 & -0.067991400 & -0.0587028632 &   9.99 & 0\\\\\n",
       "\t284733 &  1.07617508 & -3.11635274 & -2.0514389 & -0.95318890 & -1.54483805 & -1.12464466 &  0.38557049 & -0.69801421 & -1.8294009 &  1.26914864 & ⋯ &  0.10485277 & -0.5982427 & -0.34316379 &  0.088299202 & -0.26765760 & -0.31365149 & -0.132090610 &  0.0560289943 & 664.60 & 0\\\\\n",
       "\t284744 &  2.11292937 &  0.17357338 & -2.1880480 &  0.30135015 &  0.70001190 & -0.86026004 &  0.23827512 & -0.29605747 &  0.6810697 & -0.51822985 & ⋯ &  0.12766273 &  0.5412904 & -0.14684851 & -1.139951806 &  0.37117618 & -0.03319877 & -0.001178497 & -0.0396175018 &   7.80 & 0\\\\\n",
       "\t284750 & -0.21487626 &  0.79257770 & -0.2651947 & -0.43617685 &  1.23013411 &  0.36894379 &  0.74154409 &  0.26387522 &  0.1617620 & -1.11646674 & ⋯ &  0.17793628 &  0.9807293 & -0.20082830 & -0.986811153 & -0.16634203 &  0.77545824 &  0.321541751 &  0.1149591324 &   7.88 & 0\\\\\n",
       "\t284754 &  1.46573688 & -0.61804658 & -2.8513909 &  1.42528201 &  0.89389301 & -0.95832535 &  1.50807441 & -0.62569138 & -0.3698240 &  0.21829981 & ⋯ &  0.50042609 &  0.8704913 & -0.49540999 &  0.676929397 &  0.78768759 & -0.25491793 & -0.117199621 & -0.0147369315 & 337.54 & 0\\\\\n",
       "\t284759 &  1.91137703 &  1.22089632 & -1.6651273 &  4.14879803 &  1.02944172 & -0.72760990 &  0.50074482 & -0.19861407 & -1.1405646 &  0.29564853 & ⋯ & -0.42911569 & -1.1841976 &  0.28866057 & -0.418322696 & -0.22272861 & -0.33582969 & -0.001157886 &  0.0175559411 &   6.75 & 0\\\\\n",
       "\t284761 & -0.65739261 &  1.03898723 & -1.4981620 & -1.88937444 &  2.81951976 &  3.33392537 &  0.28756918 &  0.95860408 &  0.4087111 &  0.54103675 & ⋯ & -0.35733049 & -0.7835532 &  0.13847084 &  0.677220906 & -0.30627850 &  0.17572426 &  0.580689093 &  0.2810843630 &   1.78 & 0\\\\\n",
       "\t284763 & -1.19165359 & -0.44122592 &  1.7297472 &  0.33737269 &  1.71898922 &  5.49309244 & -1.27310072 &  1.68639380 &  1.1268067 & -0.67617863 & ⋯ &  0.14931139 &  0.6989382 & -0.19688478 &  0.731485389 &  0.66739129 & -0.13334680 &  0.417417507 &  0.1619667492 &  79.99 & 0\\\\\n",
       "\t284774 & -0.06613576 &  0.99629639 & -0.9185644 & -0.92324161 &  1.25652164 &  0.04744553 &  0.70581951 &  0.23232998 &  0.2131572 & -0.31204764 & ⋯ & -0.39721044 & -1.0380994 &  0.00212035 & -0.512741023 & -0.34972124 &  0.16869287 &  0.316673794 &  0.1200654056 &   3.57 & 0\\\\\n",
       "\t284780 &  1.97517827 & -0.61624401 & -2.6282950 & -0.40624559 &  2.32780433 &  3.66474012 & -0.53329691 &  0.84293703 &  1.1287979 & -0.22074419 & ⋯ &  0.08604338 &  0.5436127 & -0.03212929 &  0.768379191 &  0.47768760 & -0.03183282 &  0.014150872 & -0.0665416968 &  25.00 & 0\\\\\n",
       "\t284784 & -1.79609202 &  1.92917844 & -2.8284173 & -1.68984379 &  2.19957203 &  3.12373190 & -0.27071406 &  1.65749525 &  0.4658038 &  0.83293091 & ⋯ &  0.27117008 &  1.1457502 &  0.08478275 &  0.721269433 & -0.52990598 & -0.24011733 &  0.129125565 & -0.0806203045 &  11.46 & 0\\\\\n",
       "\t284789 &  2.00741803 & -0.28023497 & -0.2081132 &  0.33526094 & -0.71579823 & -0.75137308 & -0.45897191 & -0.14014038 &  0.9599713 & -0.02828406 & ⋯ & -0.20826014 & -0.4303466 &  0.41676533 &  0.064819455 & -0.60833652 &  0.26843624 & -0.028068547 & -0.0413674217 &   3.99 & 0\\\\\n",
       "\t284791 & -0.51551285 &  0.97195037 & -1.0145802 & -0.67703687 &  0.91243000 & -0.31618711 &  0.39613749 &  0.53236435 & -0.2246059 & -0.75336512 & ⋯ & -0.28030189 & -0.8499192 &  0.30024545 &  0.000606787 & -0.37637895 &  0.12866028 & -0.015204853 & -0.0214855616 &   9.81 & 0\\\\\n",
       "\t284793 & -0.72412286 &  1.48521564 & -1.1322181 & -0.60719026 &  0.70949876 & -0.48263811 &  0.54839312 &  0.34300332 & -0.2263229 & -0.34813371 & ⋯ &  0.41462062 &  1.3075111 & -0.05954451 &  0.242668830 & -0.66542446 & -0.26986930 & -0.170579064 & -0.0306924981 &   3.99 & 0\\\\\n",
       "\t284804 & -0.73278867 & -0.05508049 &  2.0350297 & -0.73858858 &  0.86822940 &  1.05841527 &  0.02432970 &  0.29486870 &  0.5848000 & -0.97592606 & ⋯ &  0.21420534 &  0.9243836 &  0.01246304 & -1.016225669 & -0.60662399 & -0.39525507 &  0.068472470 & -0.0535273892 &  24.79 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 56961 × 30\n",
       "\n",
       "| <!--/--> | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | V10 &lt;dbl&gt; | ⋯ ⋯ | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; | Class &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | -1.35980713 | -0.07278117 |  2.53634674 |  1.37815522 | -0.338320770 |  0.46238778 |  0.239598554 |  0.09869790 |  0.36378697 |  0.09079417 | ⋯ | -0.01830678 |  0.27783758 | -0.110473910 |  0.066928075 |  0.12853936 | -0.18911484 |  0.133558377 | -0.021053053 | 149.62 | 0 |\n",
       "| 3 | -1.35835406 | -1.34016307 |  1.77320934 |  0.37977959 | -0.503198133 |  1.80049938 |  0.791460956 |  0.24767579 | -1.51465432 |  0.20764287 | ⋯ |  0.24799815 |  0.77167940 |  0.909412262 | -0.689280956 | -0.32764183 | -0.13909657 | -0.055352794 | -0.059751841 | 378.66 | 0 |\n",
       "| 14 |  1.06937359 |  0.28772213 |  0.82861273 |  2.71252043 | -0.178398016 |  0.33754373 | -0.096716862 |  0.11598174 | -0.22108257 |  0.46023044 | ⋯ | -0.03687553 |  0.07441240 | -0.071407433 |  0.104743753 |  0.54826473 |  0.10409415 |  0.021491058 |  0.021293311 |  27.50 | 0 |\n",
       "| 20 |  1.49293598 | -1.02934573 |  0.45479473 | -1.43802588 | -1.555434101 | -0.72096115 | -1.080664130 | -0.05312712 | -1.97868160 |  1.63807604 | ⋯ | -0.17764985 | -0.17507381 |  0.040002219 |  0.295813863 |  0.33293060 | -0.22038485 |  0.022298436 |  0.007602256 |   5.00 | 0 |\n",
       "| 24 |  0.24749113 |  0.27766563 |  1.18547084 | -0.09260255 | -1.314393979 | -0.15011600 | -0.946364950 | -1.61793505 |  1.54407140 | -0.82988060 | ⋯ |  1.65018036 |  0.20045409 | -0.185352508 |  0.423073148 |  0.82059126 | -0.22763186 |  0.336634447 |  0.250475352 |  22.75 | 0 |\n",
       "| 29 | -0.41428881 |  0.90543732 |  1.72745294 |  1.47347127 |  0.007442741 | -0.20033068 |  0.740228319 | -0.02924740 | -0.59339202 | -0.34618823 | ⋯ |  0.07723743 |  0.45733060 | -0.038499725 |  0.642521903 | -0.18389134 | -0.27746402 |  0.182687486 |  0.152664645 |  33.00 | 0 |\n",
       "| 31 |  1.23742903 |  0.06104258 |  0.38052588 |  0.76156411 | -0.359770710 | -0.49408415 |  0.006494218 | -0.13386238 |  0.43880974 | -0.20735805 | ⋯ | -0.24568250 | -0.53090026 | -0.044265397 |  0.079168029 |  0.50913569 |  0.28885783 | -0.022704982 |  0.011836231 |  17.28 | 0 |\n",
       "| 33 | -0.52991228 |  0.87389158 |  1.34724733 |  0.14545668 |  0.414208858 |  0.10022309 |  0.711206083 |  0.17606596 | -0.28671693 | -0.48468768 | ⋯ |  0.04694907 |  0.20810486 | -0.185548347 |  0.001030660 |  0.09881570 | -0.55290360 | -0.073288084 |  0.023307045 |   6.14 | 0 |\n",
       "| 44 | -0.93573151 |  0.17041577 |  2.74626127 | -1.07796491 | -0.305594036 |  0.01157704 | -0.296178451 |  0.40277557 | -0.04047175 | -0.85204598 | ⋯ |  0.40121202 |  1.06486425 | -0.158325436 |  0.295505486 | -0.25936965 |  0.75419472 |  0.046663770 |  0.093947918 |   9.10 | 0 |\n",
       "| 50 | -1.06323568 |  1.41819063 |  1.08667286 |  1.24143960 |  0.002306126 |  0.04590158 |  0.514120897 |  0.24125240 | -0.15449995 |  0.28067262 | ⋯ | -0.05722847 |  0.31415300 | -0.129862928 |  0.114283708 | -0.02781248 | -0.25993702 |  0.118753640 | -0.008956298 |  20.22 | 0 |\n",
       "| 54 |  1.09552461 | -0.11608535 |  1.39791192 |  1.49754690 | -1.049123999 |  0.07283853 | -0.723802080 |  0.28753247 |  0.99632681 | -0.14914465 | ⋯ | -0.03323417 |  0.09326188 |  0.089498395 |  0.361261298 |  0.25096295 | -0.37827998 |  0.081023900 |  0.034226938 |   2.09 | 0 |\n",
       "| 59 |  1.11069200 |  0.08194190 |  0.40606304 |  1.29074038 | -0.169813148 |  0.12095538 | -0.080845205 |  0.17437308 |  0.15207073 |  0.06526672 | ⋯ | -0.05602398 | -0.01160309 | -0.070482892 |  0.004345191 |  0.60392864 | -0.32742445 |  0.029889689 |  0.004944296 |  13.84 | 0 |\n",
       "| 61 |  0.98606333 | -0.20296459 | -0.49276815 |  0.40769127 |  0.305660256 | -0.23052918 |  0.585028086 | -0.20822459 | -0.24750345 | -0.19225313 | ⋯ | -0.30587393 | -1.21655527 | -0.077601526 | -0.741340788 |  0.28688112 |  0.20034670 | -0.075203351 |  0.027271219 | 169.05 | 0 |\n",
       "| 63 |  1.14552439 |  0.57506797 |  0.19400846 |  2.59819174 | -0.092210023 | -1.04442958 |  0.531587593 | -0.24188813 | -0.89628717 |  0.75795233 | ⋯ |  0.01110633 | -0.11970310 | -0.076509528 |  0.691320431 |  0.63398398 |  0.04874127 | -0.053191942 |  0.016251499 |  34.13 | 0 |\n",
       "| 74 | -0.58062897 |  0.48268393 |  1.33312308 | -0.25308002 | -0.028468940 | -0.51916570 |  0.503249461 |  0.11777348 |  0.11711224 | -0.42048754 | ⋯ | -0.04214233 | -0.14870728 |  0.001451165 |  0.302764487 | -0.68071420 | -0.01555392 | -0.006307004 |  0.164222205 |  21.66 | 0 |\n",
       "| 80 | -0.67170855 |  0.59450259 |  0.21641594 | -0.86731064 |  2.966908301 |  3.63249487 |  0.563295075 |  0.67302560 | -0.18876614 | -0.40437829 | ⋯ | -0.13644097 | -0.30036203 | -0.331691623 |  0.996382471 |  0.50246949 | -0.51804305 | -0.208275755 | -0.116048406 |  14.80 | 0 |\n",
       "| 84 | -1.19896767 | -1.47410047 |  1.84032599 | -4.51582435 |  0.327567428 | -0.17446928 |  0.959725705 | -1.02645623 |  1.70043458 | -0.07894176 | ⋯ | -0.45316942 |  0.33461404 | -0.364541412 | -0.310185782 | -0.30259949 | -1.24392415 | -1.123456545 | -0.734351086 |  89.17 | 0 |\n",
       "| 89 |  0.08699619 | -0.05198874 | -0.49788244 | -3.15190786 |  2.558400362 |  2.79667097 |  0.470283271 |  0.26533280 |  0.91951346 | -0.73558569 | ⋯ | -0.23942558 | -0.43734214 |  0.018425768 |  1.013037763 | -0.25892656 | -0.29318925 | -0.394955581 | -0.435995593 |  10.84 | 0 |\n",
       "| 91 |  0.92102402 | -0.16244686 | -0.09433137 |  0.47408393 | -0.021485961 | -0.39750631 |  0.482642979 | -0.11749597 | -0.57783603 | -0.01860714 | ⋯ | -0.20938111 | -0.93010730 |  0.028509911 |  0.032682009 |  0.15513050 |  0.13325047 | -0.073534231 |  0.022349145 | 149.90 | 0 |\n",
       "| 93 |  1.10702938 |  0.21644100 |  0.53837815 |  1.47639799 | -0.251941920 | -0.34067971 |  0.154091745 | -0.08650255 |  0.14442020 | -0.15737463 | ⋯ | -0.06003745 |  0.05988412 | -0.047526366 |  0.443992419 |  0.64029576 | -0.33765713 |  0.042108484 |  0.024264710 |  26.72 | 0 |\n",
       "| 104 | -0.60802693 |  0.30669360 |  1.47300415 |  1.19112725 |  0.021264671 |  0.88844249 |  1.190491174 |  0.04214674 | -0.44642561 | -0.08038612 | ⋯ |  0.04650638 |  0.16516250 |  0.063974176 | -0.333791686 |  0.13177582 | -0.21769193 | -0.082183353 | -0.116730187 | 168.56 | 0 |\n",
       "| 110 |  1.23904805 |  0.29328442 |  0.08647196 |  1.17827736 |  0.373343851 |  0.32559601 |  0.119318979 | -0.02547625 |  0.17321136 | -0.15418618 | ⋯ | -0.14813619 | -0.11189263 | -0.173207278 | -0.714729129 |  0.81735994 | -0.26384275 |  0.047776818 |  0.008735382 |   1.00 | 0 |\n",
       "| 114 |  1.03837033 |  0.12748613 |  0.18445589 |  1.10994979 |  0.441698900 |  0.94528253 | -0.036714604 |  0.35099500 |  0.11894954 | -0.24328924 | ⋯ |  0.10251980 |  0.60508853 |  0.023092156 | -0.626462661 |  0.47912027 | -0.16693684 |  0.081246718 |  0.001191576 |   1.18 | 0 |\n",
       "| 119 | -0.99717576 |  0.22836530 |  1.71533994 | -0.42006677 |  0.560837845 |  0.56472505 |  0.846046550 |  0.19749082 | -0.09720188 | -0.43934683 | ⋯ | -0.07024076 |  0.01544495 |  0.072651066 | -0.272271751 | -0.08768151 |  0.13813212 |  0.125901816 | -0.063022320 |  86.43 | 0 |\n",
       "| 121 | -1.18595403 | -0.21880844 |  1.10100483 | -1.40699713 |  1.261783204 | -0.33770907 |  1.191747221 | -0.42738311 |  0.27667889 | -0.21539920 | ⋯ | -0.36283038 | -0.41881699 |  0.521401264 | -0.922427393 | -0.13984027 |  0.70978702 | -0.076248716 | -0.383942454 |  49.95 | 0 |\n",
       "| 123 | -0.62247837 |  0.01488140 |  1.05248874 | -1.64457383 | -0.538265319 | -0.83552821 |  0.517233526 | -1.10596237 | -1.31174062 |  0.57746838 | ⋯ |  0.41881889 | -0.76212234 | -0.098939524 |  0.502972747 | -0.65525128 |  0.74341921 | -0.020568090 | -0.118060229 | 104.94 | 0 |\n",
       "| 134 | -0.83320034 |  0.77878712 |  2.61923666 |  2.61286413 | -0.516937610 |  0.55834601 |  0.316871358 |  0.20664711 | -0.73859916 |  0.21434036 | ⋯ |  0.18871128 |  0.67860587 | -0.133148108 |  0.636175834 |  0.30932909 |  0.27214995 | -0.078460786 |  0.007343970 |  79.91 | 0 |\n",
       "| 140 | -4.25759744 |  1.64948917 | -1.59124167 | -1.37431677 | -1.180135992 | -0.33103953 | -0.117991556 |  1.59203218 |  0.41599568 |  0.15916328 | ⋯ | -0.45256781 | -0.67170252 |  0.001422276 | -0.876376518 |  0.07009822 |  0.72958230 | -0.002942371 | -0.481496958 | 124.67 | 0 |\n",
       "| 144 | -0.58985594 |  0.93306987 | -0.26807262 |  0.12524463 |  2.396991769 |  3.87794520 |  0.189985383 |  0.96038859 | -0.23000013 |  0.29511018 | ⋯ | -0.15439733 | -0.17483415 | -0.201368584 |  1.013438753 |  0.19441248 | -0.23176497 |  0.541146887 |  0.255373813 |  37.13 | 0 |\n",
       "| 149 | -0.23841096 |  0.50926277 |  1.95200070 |  0.77906595 | -0.378940130 |  0.25113656 | -0.072412057 |  0.22875486 |  0.21089959 | -0.37381413 | ⋯ |  0.21744861 |  0.90377655 | -0.121348660 |  0.141224740 | -0.61385385 |  0.57592018 |  0.193591769 |  0.165131782 |   2.99 | 0 |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋱ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| 284660 | -2.73434961 |  0.11540489 | -1.2469853 | -1.47163002 |  1.55866703 | -1.55262259 |  1.30500687 |  0.42144619 | -1.4754347 | -1.55812166 | ⋯ |  0.50875065 |  0.7511849 | -0.90376604 |  0.897164402 |  1.70441566 |  0.31367118 | -0.441428119 | -0.3719709701 |  76.00 | 0 |\n",
       "| 284664 |  1.95828670 | -0.19585812 | -1.4940227 |  0.73901804 |  0.23412703 | -0.24025555 | -0.03799524 | -0.08961327 |  1.1589403 | -0.67241546 | ⋯ | -0.44519214 | -0.9758691 |  0.22621134 |  0.414537226 | -0.11517106 |  0.25815004 | -0.039310151 | -0.0230666104 |  43.09 | 0 |\n",
       "| 284669 |  1.78632585 | -0.38973948 | -0.8171634 |  1.24780987 | -0.18497019 | -0.13274526 | -0.16544779 |  0.03382061 |  0.5580742 |  0.35001747 | ⋯ |  0.12358473 |  0.2865092 |  0.05019139 | -0.433841099 | -0.05495557 | -0.65718230 |  0.014365254 | -0.0384192895 |  91.20 | 0 |\n",
       "| 284671 | -2.31575258 |  2.38563309 | -1.5588933 | -0.70903002 | -1.09513469 | -1.15874632 | -0.59970512 |  1.72289014 | -0.1028035 |  0.11617584 | ⋯ | -0.16722135 | -0.6421290 |  0.32071139 |  0.033782329 | -0.25815727 |  0.14470589 |  0.166016716 |  0.0713901681 |   9.23 | 0 |\n",
       "| 284673 | -1.10764203 |  1.18869065 |  1.1266165 |  0.19100946 | -0.74887520 |  1.02372920 | -1.58512073 | -1.45742017 |  0.6025471 | -0.37015363 | ⋯ |  2.68485853 |  0.3083459 |  0.25811637 | -0.548003064 | -0.49351902 | -0.62846740 |  0.150128974 |  0.0169003567 |   0.01 | 0 |\n",
       "| 284684 |  1.91547450 | -0.21701885 | -0.5217310 |  1.27442970 | -0.12471489 |  0.35164029 | -0.50227602 |  0.17047028 |  0.7736684 |  0.28049952 | ⋯ |  0.25994415 |  1.0137523 |  0.06077960 |  0.726831402 |  0.15469028 | -0.48058840 |  0.047439265 | -0.0427860134 |   5.90 | 0 |\n",
       "| 284690 |  1.83399957 | -0.73608994 | -0.4832008 |  0.12739185 | -0.05889954 |  1.49223731 | -1.07443219 |  0.61566139 |  1.1601771 |  0.05998520 | ⋯ |  0.26233422 |  1.0143474 |  0.19802203 | -1.467513360 | -0.51458209 |  0.67757363 |  0.023793747 | -0.0743059426 |  11.50 | 0 |\n",
       "| 284694 | -0.97324533 |  0.36545922 |  0.5448808 | -0.01874973 |  0.82395984 | -1.83056864 |  1.63271812 | -0.26393083 | -0.3430312 | -0.89443803 | ⋯ |  0.22175065 |  0.3531573 |  0.03799850 |  0.798246404 |  0.26183734 | -0.82084813 |  0.052708986 |  0.1613924941 |  89.90 | 0 |\n",
       "| 284699 | -0.85768766 |  0.29094518 | -2.3914479 | -0.31545743 | -0.01445453 | -1.76559457 |  2.67177910 | -0.51125746 | -0.7401753 | -0.38463957 | ⋯ |  0.48405029 |  1.8265749 |  0.86239538 |  0.586088667 | -1.03614482 |  0.65976541 |  0.436364652 |  0.1734915778 | 307.88 | 0 |\n",
       "| 284701 |  2.04587290 | -1.20696822 |  0.7489072 | -0.52448183 | -2.29578294 | -0.93093602 | -1.64916725 |  0.03042932 |  0.6227105 |  0.69067084 | ⋯ |  0.48248785 |  1.4767459 |  0.30705800 |  0.958799368 | -0.54933445 | -0.14799662 |  0.055248229 | -0.0222821093 |  12.50 | 0 |\n",
       "| 284703 | -0.48167169 |  1.57929701 | -1.2841543 | -0.08352434 |  0.09781538 | -1.42121628 |  0.26549044 |  0.52814006 | -0.3079063 | -1.33194283 | ⋯ |  0.38898120 |  0.9310191 | -0.11444752 | -0.196205076 | -0.35053241 | -0.15616843 | -0.242230952 | -0.0002897593 |   2.32 | 0 |\n",
       "| 284714 | -3.72045714 |  3.87948948 | -2.5607745 | -2.17737109 |  0.49587187 | -1.24778498 |  1.33762244 |  0.01426936 |  2.7051184 |  4.83813357 | ⋯ | -0.23563364 |  0.5799722 | -0.01714725 |  0.647609435 |  0.40523853 |  0.05962486 |  1.596482026 |  0.7178274277 |   0.92 | 0 |\n",
       "| 284720 | -1.27726167 |  1.22042487 |  0.2424964 | -0.56952018 |  0.27986040 |  1.33838434 |  0.85088010 | -1.29462688 |  0.1873760 | -1.75908295 | ⋯ |  1.30275708 | -0.8364154 | -0.07372184 | -1.206611639 |  0.42980652 |  0.23948759 |  0.246823802 |  0.0297780973 | 157.04 | 0 |\n",
       "| 284724 | -0.27332940 |  1.11880233 | -0.3827244 | -0.61196073 |  1.51940058 | -0.84813023 |  1.79453551 | -0.59567201 | -0.4420765 | -0.89288725 | ⋯ | -0.05592114 |  0.1171239 | -0.33439925 |  0.642114091 | -0.01082399 |  0.43940482 | -0.198835175 | -0.0652823222 |  36.25 | 0 |\n",
       "| 284729 | -2.96924965 |  3.21685096 | -2.8730019 | -0.62884007 | -1.00936620 | -1.23940561 | -0.86851715 |  2.09513920 |  0.2989027 | -0.10101491 | ⋯ | -0.31438538 | -1.0509027 |  0.38790206 |  0.598871193 | -0.02031615 |  0.14691903 |  0.232855823 |  0.1221755696 |   9.99 | 0 |\n",
       "| 284731 |  2.03772756 | -0.07283719 | -1.0719067 |  0.41398555 | -0.10525421 | -1.12207508 |  0.19257610 | -0.32098730 |  0.5131737 |  0.05597329 | ⋯ | -0.27645573 | -0.6658015 |  0.33766632 | -0.008123892 | -0.31067768 |  0.19961535 | -0.067991400 | -0.0587028632 |   9.99 | 0 |\n",
       "| 284733 |  1.07617508 | -3.11635274 | -2.0514389 | -0.95318890 | -1.54483805 | -1.12464466 |  0.38557049 | -0.69801421 | -1.8294009 |  1.26914864 | ⋯ |  0.10485277 | -0.5982427 | -0.34316379 |  0.088299202 | -0.26765760 | -0.31365149 | -0.132090610 |  0.0560289943 | 664.60 | 0 |\n",
       "| 284744 |  2.11292937 |  0.17357338 | -2.1880480 |  0.30135015 |  0.70001190 | -0.86026004 |  0.23827512 | -0.29605747 |  0.6810697 | -0.51822985 | ⋯ |  0.12766273 |  0.5412904 | -0.14684851 | -1.139951806 |  0.37117618 | -0.03319877 | -0.001178497 | -0.0396175018 |   7.80 | 0 |\n",
       "| 284750 | -0.21487626 |  0.79257770 | -0.2651947 | -0.43617685 |  1.23013411 |  0.36894379 |  0.74154409 |  0.26387522 |  0.1617620 | -1.11646674 | ⋯ |  0.17793628 |  0.9807293 | -0.20082830 | -0.986811153 | -0.16634203 |  0.77545824 |  0.321541751 |  0.1149591324 |   7.88 | 0 |\n",
       "| 284754 |  1.46573688 | -0.61804658 | -2.8513909 |  1.42528201 |  0.89389301 | -0.95832535 |  1.50807441 | -0.62569138 | -0.3698240 |  0.21829981 | ⋯ |  0.50042609 |  0.8704913 | -0.49540999 |  0.676929397 |  0.78768759 | -0.25491793 | -0.117199621 | -0.0147369315 | 337.54 | 0 |\n",
       "| 284759 |  1.91137703 |  1.22089632 | -1.6651273 |  4.14879803 |  1.02944172 | -0.72760990 |  0.50074482 | -0.19861407 | -1.1405646 |  0.29564853 | ⋯ | -0.42911569 | -1.1841976 |  0.28866057 | -0.418322696 | -0.22272861 | -0.33582969 | -0.001157886 |  0.0175559411 |   6.75 | 0 |\n",
       "| 284761 | -0.65739261 |  1.03898723 | -1.4981620 | -1.88937444 |  2.81951976 |  3.33392537 |  0.28756918 |  0.95860408 |  0.4087111 |  0.54103675 | ⋯ | -0.35733049 | -0.7835532 |  0.13847084 |  0.677220906 | -0.30627850 |  0.17572426 |  0.580689093 |  0.2810843630 |   1.78 | 0 |\n",
       "| 284763 | -1.19165359 | -0.44122592 |  1.7297472 |  0.33737269 |  1.71898922 |  5.49309244 | -1.27310072 |  1.68639380 |  1.1268067 | -0.67617863 | ⋯ |  0.14931139 |  0.6989382 | -0.19688478 |  0.731485389 |  0.66739129 | -0.13334680 |  0.417417507 |  0.1619667492 |  79.99 | 0 |\n",
       "| 284774 | -0.06613576 |  0.99629639 | -0.9185644 | -0.92324161 |  1.25652164 |  0.04744553 |  0.70581951 |  0.23232998 |  0.2131572 | -0.31204764 | ⋯ | -0.39721044 | -1.0380994 |  0.00212035 | -0.512741023 | -0.34972124 |  0.16869287 |  0.316673794 |  0.1200654056 |   3.57 | 0 |\n",
       "| 284780 |  1.97517827 | -0.61624401 | -2.6282950 | -0.40624559 |  2.32780433 |  3.66474012 | -0.53329691 |  0.84293703 |  1.1287979 | -0.22074419 | ⋯ |  0.08604338 |  0.5436127 | -0.03212929 |  0.768379191 |  0.47768760 | -0.03183282 |  0.014150872 | -0.0665416968 |  25.00 | 0 |\n",
       "| 284784 | -1.79609202 |  1.92917844 | -2.8284173 | -1.68984379 |  2.19957203 |  3.12373190 | -0.27071406 |  1.65749525 |  0.4658038 |  0.83293091 | ⋯ |  0.27117008 |  1.1457502 |  0.08478275 |  0.721269433 | -0.52990598 | -0.24011733 |  0.129125565 | -0.0806203045 |  11.46 | 0 |\n",
       "| 284789 |  2.00741803 | -0.28023497 | -0.2081132 |  0.33526094 | -0.71579823 | -0.75137308 | -0.45897191 | -0.14014038 |  0.9599713 | -0.02828406 | ⋯ | -0.20826014 | -0.4303466 |  0.41676533 |  0.064819455 | -0.60833652 |  0.26843624 | -0.028068547 | -0.0413674217 |   3.99 | 0 |\n",
       "| 284791 | -0.51551285 |  0.97195037 | -1.0145802 | -0.67703687 |  0.91243000 | -0.31618711 |  0.39613749 |  0.53236435 | -0.2246059 | -0.75336512 | ⋯ | -0.28030189 | -0.8499192 |  0.30024545 |  0.000606787 | -0.37637895 |  0.12866028 | -0.015204853 | -0.0214855616 |   9.81 | 0 |\n",
       "| 284793 | -0.72412286 |  1.48521564 | -1.1322181 | -0.60719026 |  0.70949876 | -0.48263811 |  0.54839312 |  0.34300332 | -0.2263229 | -0.34813371 | ⋯ |  0.41462062 |  1.3075111 | -0.05954451 |  0.242668830 | -0.66542446 | -0.26986930 | -0.170579064 | -0.0306924981 |   3.99 | 0 |\n",
       "| 284804 | -0.73278867 | -0.05508049 |  2.0350297 | -0.73858858 |  0.86822940 |  1.05841527 |  0.02432970 |  0.29486870 |  0.5848000 | -0.97592606 | ⋯ |  0.21420534 |  0.9243836 |  0.01246304 | -1.016225669 | -0.60662399 | -0.39525507 |  0.068472470 | -0.0535273892 |  24.79 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "       V1          V2          V3          V4          V5           V6         \n",
       "1      -1.35980713 -0.07278117  2.53634674  1.37815522 -0.338320770  0.46238778\n",
       "3      -1.35835406 -1.34016307  1.77320934  0.37977959 -0.503198133  1.80049938\n",
       "14      1.06937359  0.28772213  0.82861273  2.71252043 -0.178398016  0.33754373\n",
       "20      1.49293598 -1.02934573  0.45479473 -1.43802588 -1.555434101 -0.72096115\n",
       "24      0.24749113  0.27766563  1.18547084 -0.09260255 -1.314393979 -0.15011600\n",
       "29     -0.41428881  0.90543732  1.72745294  1.47347127  0.007442741 -0.20033068\n",
       "31      1.23742903  0.06104258  0.38052588  0.76156411 -0.359770710 -0.49408415\n",
       "33     -0.52991228  0.87389158  1.34724733  0.14545668  0.414208858  0.10022309\n",
       "44     -0.93573151  0.17041577  2.74626127 -1.07796491 -0.305594036  0.01157704\n",
       "50     -1.06323568  1.41819063  1.08667286  1.24143960  0.002306126  0.04590158\n",
       "54      1.09552461 -0.11608535  1.39791192  1.49754690 -1.049123999  0.07283853\n",
       "59      1.11069200  0.08194190  0.40606304  1.29074038 -0.169813148  0.12095538\n",
       "61      0.98606333 -0.20296459 -0.49276815  0.40769127  0.305660256 -0.23052918\n",
       "63      1.14552439  0.57506797  0.19400846  2.59819174 -0.092210023 -1.04442958\n",
       "74     -0.58062897  0.48268393  1.33312308 -0.25308002 -0.028468940 -0.51916570\n",
       "80     -0.67170855  0.59450259  0.21641594 -0.86731064  2.966908301  3.63249487\n",
       "84     -1.19896767 -1.47410047  1.84032599 -4.51582435  0.327567428 -0.17446928\n",
       "89      0.08699619 -0.05198874 -0.49788244 -3.15190786  2.558400362  2.79667097\n",
       "91      0.92102402 -0.16244686 -0.09433137  0.47408393 -0.021485961 -0.39750631\n",
       "93      1.10702938  0.21644100  0.53837815  1.47639799 -0.251941920 -0.34067971\n",
       "104    -0.60802693  0.30669360  1.47300415  1.19112725  0.021264671  0.88844249\n",
       "110     1.23904805  0.29328442  0.08647196  1.17827736  0.373343851  0.32559601\n",
       "114     1.03837033  0.12748613  0.18445589  1.10994979  0.441698900  0.94528253\n",
       "119    -0.99717576  0.22836530  1.71533994 -0.42006677  0.560837845  0.56472505\n",
       "121    -1.18595403 -0.21880844  1.10100483 -1.40699713  1.261783204 -0.33770907\n",
       "123    -0.62247837  0.01488140  1.05248874 -1.64457383 -0.538265319 -0.83552821\n",
       "134    -0.83320034  0.77878712  2.61923666  2.61286413 -0.516937610  0.55834601\n",
       "140    -4.25759744  1.64948917 -1.59124167 -1.37431677 -1.180135992 -0.33103953\n",
       "144    -0.58985594  0.93306987 -0.26807262  0.12524463  2.396991769  3.87794520\n",
       "149    -0.23841096  0.50926277  1.95200070  0.77906595 -0.378940130  0.25113656\n",
       "⋮      ⋮           ⋮           ⋮           ⋮           ⋮            ⋮          \n",
       "284660 -2.73434961  0.11540489 -1.2469853  -1.47163002  1.55866703  -1.55262259\n",
       "284664  1.95828670 -0.19585812 -1.4940227   0.73901804  0.23412703  -0.24025555\n",
       "284669  1.78632585 -0.38973948 -0.8171634   1.24780987 -0.18497019  -0.13274526\n",
       "284671 -2.31575258  2.38563309 -1.5588933  -0.70903002 -1.09513469  -1.15874632\n",
       "284673 -1.10764203  1.18869065  1.1266165   0.19100946 -0.74887520   1.02372920\n",
       "284684  1.91547450 -0.21701885 -0.5217310   1.27442970 -0.12471489   0.35164029\n",
       "284690  1.83399957 -0.73608994 -0.4832008   0.12739185 -0.05889954   1.49223731\n",
       "284694 -0.97324533  0.36545922  0.5448808  -0.01874973  0.82395984  -1.83056864\n",
       "284699 -0.85768766  0.29094518 -2.3914479  -0.31545743 -0.01445453  -1.76559457\n",
       "284701  2.04587290 -1.20696822  0.7489072  -0.52448183 -2.29578294  -0.93093602\n",
       "284703 -0.48167169  1.57929701 -1.2841543  -0.08352434  0.09781538  -1.42121628\n",
       "284714 -3.72045714  3.87948948 -2.5607745  -2.17737109  0.49587187  -1.24778498\n",
       "284720 -1.27726167  1.22042487  0.2424964  -0.56952018  0.27986040   1.33838434\n",
       "284724 -0.27332940  1.11880233 -0.3827244  -0.61196073  1.51940058  -0.84813023\n",
       "284729 -2.96924965  3.21685096 -2.8730019  -0.62884007 -1.00936620  -1.23940561\n",
       "284731  2.03772756 -0.07283719 -1.0719067   0.41398555 -0.10525421  -1.12207508\n",
       "284733  1.07617508 -3.11635274 -2.0514389  -0.95318890 -1.54483805  -1.12464466\n",
       "284744  2.11292937  0.17357338 -2.1880480   0.30135015  0.70001190  -0.86026004\n",
       "284750 -0.21487626  0.79257770 -0.2651947  -0.43617685  1.23013411   0.36894379\n",
       "284754  1.46573688 -0.61804658 -2.8513909   1.42528201  0.89389301  -0.95832535\n",
       "284759  1.91137703  1.22089632 -1.6651273   4.14879803  1.02944172  -0.72760990\n",
       "284761 -0.65739261  1.03898723 -1.4981620  -1.88937444  2.81951976   3.33392537\n",
       "284763 -1.19165359 -0.44122592  1.7297472   0.33737269  1.71898922   5.49309244\n",
       "284774 -0.06613576  0.99629639 -0.9185644  -0.92324161  1.25652164   0.04744553\n",
       "284780  1.97517827 -0.61624401 -2.6282950  -0.40624559  2.32780433   3.66474012\n",
       "284784 -1.79609202  1.92917844 -2.8284173  -1.68984379  2.19957203   3.12373190\n",
       "284789  2.00741803 -0.28023497 -0.2081132   0.33526094 -0.71579823  -0.75137308\n",
       "284791 -0.51551285  0.97195037 -1.0145802  -0.67703687  0.91243000  -0.31618711\n",
       "284793 -0.72412286  1.48521564 -1.1322181  -0.60719026  0.70949876  -0.48263811\n",
       "284804 -0.73278867 -0.05508049  2.0350297  -0.73858858  0.86822940   1.05841527\n",
       "       V7           V8          V9          V10         ⋯ V21        \n",
       "1       0.239598554  0.09869790  0.36378697  0.09079417 ⋯ -0.01830678\n",
       "3       0.791460956  0.24767579 -1.51465432  0.20764287 ⋯  0.24799815\n",
       "14     -0.096716862  0.11598174 -0.22108257  0.46023044 ⋯ -0.03687553\n",
       "20     -1.080664130 -0.05312712 -1.97868160  1.63807604 ⋯ -0.17764985\n",
       "24     -0.946364950 -1.61793505  1.54407140 -0.82988060 ⋯  1.65018036\n",
       "29      0.740228319 -0.02924740 -0.59339202 -0.34618823 ⋯  0.07723743\n",
       "31      0.006494218 -0.13386238  0.43880974 -0.20735805 ⋯ -0.24568250\n",
       "33      0.711206083  0.17606596 -0.28671693 -0.48468768 ⋯  0.04694907\n",
       "44     -0.296178451  0.40277557 -0.04047175 -0.85204598 ⋯  0.40121202\n",
       "50      0.514120897  0.24125240 -0.15449995  0.28067262 ⋯ -0.05722847\n",
       "54     -0.723802080  0.28753247  0.99632681 -0.14914465 ⋯ -0.03323417\n",
       "59     -0.080845205  0.17437308  0.15207073  0.06526672 ⋯ -0.05602398\n",
       "61      0.585028086 -0.20822459 -0.24750345 -0.19225313 ⋯ -0.30587393\n",
       "63      0.531587593 -0.24188813 -0.89628717  0.75795233 ⋯  0.01110633\n",
       "74      0.503249461  0.11777348  0.11711224 -0.42048754 ⋯ -0.04214233\n",
       "80      0.563295075  0.67302560 -0.18876614 -0.40437829 ⋯ -0.13644097\n",
       "84      0.959725705 -1.02645623  1.70043458 -0.07894176 ⋯ -0.45316942\n",
       "89      0.470283271  0.26533280  0.91951346 -0.73558569 ⋯ -0.23942558\n",
       "91      0.482642979 -0.11749597 -0.57783603 -0.01860714 ⋯ -0.20938111\n",
       "93      0.154091745 -0.08650255  0.14442020 -0.15737463 ⋯ -0.06003745\n",
       "104     1.190491174  0.04214674 -0.44642561 -0.08038612 ⋯  0.04650638\n",
       "110     0.119318979 -0.02547625  0.17321136 -0.15418618 ⋯ -0.14813619\n",
       "114    -0.036714604  0.35099500  0.11894954 -0.24328924 ⋯  0.10251980\n",
       "119     0.846046550  0.19749082 -0.09720188 -0.43934683 ⋯ -0.07024076\n",
       "121     1.191747221 -0.42738311  0.27667889 -0.21539920 ⋯ -0.36283038\n",
       "123     0.517233526 -1.10596237 -1.31174062  0.57746838 ⋯  0.41881889\n",
       "134     0.316871358  0.20664711 -0.73859916  0.21434036 ⋯  0.18871128\n",
       "140    -0.117991556  1.59203218  0.41599568  0.15916328 ⋯ -0.45256781\n",
       "144     0.189985383  0.96038859 -0.23000013  0.29511018 ⋯ -0.15439733\n",
       "149    -0.072412057  0.22875486  0.21089959 -0.37381413 ⋯  0.21744861\n",
       "⋮      ⋮            ⋮           ⋮           ⋮           ⋱ ⋮          \n",
       "284660  1.30500687   0.42144619 -1.4754347  -1.55812166 ⋯  0.50875065\n",
       "284664 -0.03799524  -0.08961327  1.1589403  -0.67241546 ⋯ -0.44519214\n",
       "284669 -0.16544779   0.03382061  0.5580742   0.35001747 ⋯  0.12358473\n",
       "284671 -0.59970512   1.72289014 -0.1028035   0.11617584 ⋯ -0.16722135\n",
       "284673 -1.58512073  -1.45742017  0.6025471  -0.37015363 ⋯  2.68485853\n",
       "284684 -0.50227602   0.17047028  0.7736684   0.28049952 ⋯  0.25994415\n",
       "284690 -1.07443219   0.61566139  1.1601771   0.05998520 ⋯  0.26233422\n",
       "284694  1.63271812  -0.26393083 -0.3430312  -0.89443803 ⋯  0.22175065\n",
       "284699  2.67177910  -0.51125746 -0.7401753  -0.38463957 ⋯  0.48405029\n",
       "284701 -1.64916725   0.03042932  0.6227105   0.69067084 ⋯  0.48248785\n",
       "284703  0.26549044   0.52814006 -0.3079063  -1.33194283 ⋯  0.38898120\n",
       "284714  1.33762244   0.01426936  2.7051184   4.83813357 ⋯ -0.23563364\n",
       "284720  0.85088010  -1.29462688  0.1873760  -1.75908295 ⋯  1.30275708\n",
       "284724  1.79453551  -0.59567201 -0.4420765  -0.89288725 ⋯ -0.05592114\n",
       "284729 -0.86851715   2.09513920  0.2989027  -0.10101491 ⋯ -0.31438538\n",
       "284731  0.19257610  -0.32098730  0.5131737   0.05597329 ⋯ -0.27645573\n",
       "284733  0.38557049  -0.69801421 -1.8294009   1.26914864 ⋯  0.10485277\n",
       "284744  0.23827512  -0.29605747  0.6810697  -0.51822985 ⋯  0.12766273\n",
       "284750  0.74154409   0.26387522  0.1617620  -1.11646674 ⋯  0.17793628\n",
       "284754  1.50807441  -0.62569138 -0.3698240   0.21829981 ⋯  0.50042609\n",
       "284759  0.50074482  -0.19861407 -1.1405646   0.29564853 ⋯ -0.42911569\n",
       "284761  0.28756918   0.95860408  0.4087111   0.54103675 ⋯ -0.35733049\n",
       "284763 -1.27310072   1.68639380  1.1268067  -0.67617863 ⋯  0.14931139\n",
       "284774  0.70581951   0.23232998  0.2131572  -0.31204764 ⋯ -0.39721044\n",
       "284780 -0.53329691   0.84293703  1.1287979  -0.22074419 ⋯  0.08604338\n",
       "284784 -0.27071406   1.65749525  0.4658038   0.83293091 ⋯  0.27117008\n",
       "284789 -0.45897191  -0.14014038  0.9599713  -0.02828406 ⋯ -0.20826014\n",
       "284791  0.39613749   0.53236435 -0.2246059  -0.75336512 ⋯ -0.28030189\n",
       "284793  0.54839312   0.34300332 -0.2263229  -0.34813371 ⋯  0.41462062\n",
       "284804  0.02432970   0.29486870  0.5848000  -0.97592606 ⋯  0.21420534\n",
       "       V22         V23          V24          V25         V26        \n",
       "1       0.27783758 -0.110473910  0.066928075  0.12853936 -0.18911484\n",
       "3       0.77167940  0.909412262 -0.689280956 -0.32764183 -0.13909657\n",
       "14      0.07441240 -0.071407433  0.104743753  0.54826473  0.10409415\n",
       "20     -0.17507381  0.040002219  0.295813863  0.33293060 -0.22038485\n",
       "24      0.20045409 -0.185352508  0.423073148  0.82059126 -0.22763186\n",
       "29      0.45733060 -0.038499725  0.642521903 -0.18389134 -0.27746402\n",
       "31     -0.53090026 -0.044265397  0.079168029  0.50913569  0.28885783\n",
       "33      0.20810486 -0.185548347  0.001030660  0.09881570 -0.55290360\n",
       "44      1.06486425 -0.158325436  0.295505486 -0.25936965  0.75419472\n",
       "50      0.31415300 -0.129862928  0.114283708 -0.02781248 -0.25993702\n",
       "54      0.09326188  0.089498395  0.361261298  0.25096295 -0.37827998\n",
       "59     -0.01160309 -0.070482892  0.004345191  0.60392864 -0.32742445\n",
       "61     -1.21655527 -0.077601526 -0.741340788  0.28688112  0.20034670\n",
       "63     -0.11970310 -0.076509528  0.691320431  0.63398398  0.04874127\n",
       "74     -0.14870728  0.001451165  0.302764487 -0.68071420 -0.01555392\n",
       "80     -0.30036203 -0.331691623  0.996382471  0.50246949 -0.51804305\n",
       "84      0.33461404 -0.364541412 -0.310185782 -0.30259949 -1.24392415\n",
       "89     -0.43734214  0.018425768  1.013037763 -0.25892656 -0.29318925\n",
       "91     -0.93010730  0.028509911  0.032682009  0.15513050  0.13325047\n",
       "93      0.05988412 -0.047526366  0.443992419  0.64029576 -0.33765713\n",
       "104     0.16516250  0.063974176 -0.333791686  0.13177582 -0.21769193\n",
       "110    -0.11189263 -0.173207278 -0.714729129  0.81735994 -0.26384275\n",
       "114     0.60508853  0.023092156 -0.626462661  0.47912027 -0.16693684\n",
       "119     0.01544495  0.072651066 -0.272271751 -0.08768151  0.13813212\n",
       "121    -0.41881699  0.521401264 -0.922427393 -0.13984027  0.70978702\n",
       "123    -0.76212234 -0.098939524  0.502972747 -0.65525128  0.74341921\n",
       "134     0.67860587 -0.133148108  0.636175834  0.30932909  0.27214995\n",
       "140    -0.67170252  0.001422276 -0.876376518  0.07009822  0.72958230\n",
       "144    -0.17483415 -0.201368584  1.013438753  0.19441248 -0.23176497\n",
       "149     0.90377655 -0.121348660  0.141224740 -0.61385385  0.57592018\n",
       "⋮      ⋮           ⋮            ⋮            ⋮           ⋮          \n",
       "284660  0.7511849  -0.90376604   0.897164402  1.70441566  0.31367118\n",
       "284664 -0.9758691   0.22621134   0.414537226 -0.11517106  0.25815004\n",
       "284669  0.2865092   0.05019139  -0.433841099 -0.05495557 -0.65718230\n",
       "284671 -0.6421290   0.32071139   0.033782329 -0.25815727  0.14470589\n",
       "284673  0.3083459   0.25811637  -0.548003064 -0.49351902 -0.62846740\n",
       "284684  1.0137523   0.06077960   0.726831402  0.15469028 -0.48058840\n",
       "284690  1.0143474   0.19802203  -1.467513360 -0.51458209  0.67757363\n",
       "284694  0.3531573   0.03799850   0.798246404  0.26183734 -0.82084813\n",
       "284699  1.8265749   0.86239538   0.586088667 -1.03614482  0.65976541\n",
       "284701  1.4767459   0.30705800   0.958799368 -0.54933445 -0.14799662\n",
       "284703  0.9310191  -0.11444752  -0.196205076 -0.35053241 -0.15616843\n",
       "284714  0.5799722  -0.01714725   0.647609435  0.40523853  0.05962486\n",
       "284720 -0.8364154  -0.07372184  -1.206611639  0.42980652  0.23948759\n",
       "284724  0.1171239  -0.33439925   0.642114091 -0.01082399  0.43940482\n",
       "284729 -1.0509027   0.38790206   0.598871193 -0.02031615  0.14691903\n",
       "284731 -0.6658015   0.33766632  -0.008123892 -0.31067768  0.19961535\n",
       "284733 -0.5982427  -0.34316379   0.088299202 -0.26765760 -0.31365149\n",
       "284744  0.5412904  -0.14684851  -1.139951806  0.37117618 -0.03319877\n",
       "284750  0.9807293  -0.20082830  -0.986811153 -0.16634203  0.77545824\n",
       "284754  0.8704913  -0.49540999   0.676929397  0.78768759 -0.25491793\n",
       "284759 -1.1841976   0.28866057  -0.418322696 -0.22272861 -0.33582969\n",
       "284761 -0.7835532   0.13847084   0.677220906 -0.30627850  0.17572426\n",
       "284763  0.6989382  -0.19688478   0.731485389  0.66739129 -0.13334680\n",
       "284774 -1.0380994   0.00212035  -0.512741023 -0.34972124  0.16869287\n",
       "284780  0.5436127  -0.03212929   0.768379191  0.47768760 -0.03183282\n",
       "284784  1.1457502   0.08478275   0.721269433 -0.52990598 -0.24011733\n",
       "284789 -0.4303466   0.41676533   0.064819455 -0.60833652  0.26843624\n",
       "284791 -0.8499192   0.30024545   0.000606787 -0.37637895  0.12866028\n",
       "284793  1.3075111  -0.05954451   0.242668830 -0.66542446 -0.26986930\n",
       "284804  0.9243836   0.01246304  -1.016225669 -0.60662399 -0.39525507\n",
       "       V27          V28           Amount Class\n",
       "1       0.133558377 -0.021053053  149.62 0    \n",
       "3      -0.055352794 -0.059751841  378.66 0    \n",
       "14      0.021491058  0.021293311   27.50 0    \n",
       "20      0.022298436  0.007602256    5.00 0    \n",
       "24      0.336634447  0.250475352   22.75 0    \n",
       "29      0.182687486  0.152664645   33.00 0    \n",
       "31     -0.022704982  0.011836231   17.28 0    \n",
       "33     -0.073288084  0.023307045    6.14 0    \n",
       "44      0.046663770  0.093947918    9.10 0    \n",
       "50      0.118753640 -0.008956298   20.22 0    \n",
       "54      0.081023900  0.034226938    2.09 0    \n",
       "59      0.029889689  0.004944296   13.84 0    \n",
       "61     -0.075203351  0.027271219  169.05 0    \n",
       "63     -0.053191942  0.016251499   34.13 0    \n",
       "74     -0.006307004  0.164222205   21.66 0    \n",
       "80     -0.208275755 -0.116048406   14.80 0    \n",
       "84     -1.123456545 -0.734351086   89.17 0    \n",
       "89     -0.394955581 -0.435995593   10.84 0    \n",
       "91     -0.073534231  0.022349145  149.90 0    \n",
       "93      0.042108484  0.024264710   26.72 0    \n",
       "104    -0.082183353 -0.116730187  168.56 0    \n",
       "110     0.047776818  0.008735382    1.00 0    \n",
       "114     0.081246718  0.001191576    1.18 0    \n",
       "119     0.125901816 -0.063022320   86.43 0    \n",
       "121    -0.076248716 -0.383942454   49.95 0    \n",
       "123    -0.020568090 -0.118060229  104.94 0    \n",
       "134    -0.078460786  0.007343970   79.91 0    \n",
       "140    -0.002942371 -0.481496958  124.67 0    \n",
       "144     0.541146887  0.255373813   37.13 0    \n",
       "149     0.193591769  0.165131782    2.99 0    \n",
       "⋮      ⋮            ⋮             ⋮      ⋮    \n",
       "284660 -0.441428119 -0.3719709701  76.00 0    \n",
       "284664 -0.039310151 -0.0230666104  43.09 0    \n",
       "284669  0.014365254 -0.0384192895  91.20 0    \n",
       "284671  0.166016716  0.0713901681   9.23 0    \n",
       "284673  0.150128974  0.0169003567   0.01 0    \n",
       "284684  0.047439265 -0.0427860134   5.90 0    \n",
       "284690  0.023793747 -0.0743059426  11.50 0    \n",
       "284694  0.052708986  0.1613924941  89.90 0    \n",
       "284699  0.436364652  0.1734915778 307.88 0    \n",
       "284701  0.055248229 -0.0222821093  12.50 0    \n",
       "284703 -0.242230952 -0.0002897593   2.32 0    \n",
       "284714  1.596482026  0.7178274277   0.92 0    \n",
       "284720  0.246823802  0.0297780973 157.04 0    \n",
       "284724 -0.198835175 -0.0652823222  36.25 0    \n",
       "284729  0.232855823  0.1221755696   9.99 0    \n",
       "284731 -0.067991400 -0.0587028632   9.99 0    \n",
       "284733 -0.132090610  0.0560289943 664.60 0    \n",
       "284744 -0.001178497 -0.0396175018   7.80 0    \n",
       "284750  0.321541751  0.1149591324   7.88 0    \n",
       "284754 -0.117199621 -0.0147369315 337.54 0    \n",
       "284759 -0.001157886  0.0175559411   6.75 0    \n",
       "284761  0.580689093  0.2810843630   1.78 0    \n",
       "284763  0.417417507  0.1619667492  79.99 0    \n",
       "284774  0.316673794  0.1200654056   3.57 0    \n",
       "284780  0.014150872 -0.0665416968  25.00 0    \n",
       "284784  0.129125565 -0.0806203045  11.46 0    \n",
       "284789 -0.028068547 -0.0413674217   3.99 0    \n",
       "284791 -0.015204853 -0.0214855616   9.81 0    \n",
       "284793 -0.170579064 -0.0306924981   3.99 0    \n",
       "284804  0.068472470 -0.0535273892  24.79 0    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "test_dataset"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "c4d15b3c",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:37.553464Z",
     "iopub.status.busy": "2022-12-10T13:18:37.552058Z",
     "iopub.status.idle": "2022-12-10T13:18:37.656469Z",
     "shell.execute_reply": "2022-12-10T13:18:37.655169Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.115063,
     "end_time": "2022-12-10T13:18:37.658947",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.543884",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 1 × 29</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>V10</th><th scope=col>⋯</th><th scope=col>V20</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>-1.359807</td><td>-0.07278117</td><td>2.536347</td><td>1.378155</td><td>-0.3383208</td><td>0.4623878</td><td>0.2395986</td><td>0.0986979</td><td>0.363787</td><td>0.09079417</td><td>⋯</td><td>0.2514121</td><td>-0.01830678</td><td>0.2778376</td><td>-0.1104739</td><td>0.06692807</td><td>0.1285394</td><td>-0.1891148</td><td>0.1335584</td><td>-0.02105305</td><td>149.62</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 1 × 29\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & V10 & ⋯ & V20 & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & -1.359807 & -0.07278117 & 2.536347 & 1.378155 & -0.3383208 & 0.4623878 & 0.2395986 & 0.0986979 & 0.363787 & 0.09079417 & ⋯ & 0.2514121 & -0.01830678 & 0.2778376 & -0.1104739 & 0.06692807 & 0.1285394 & -0.1891148 & 0.1335584 & -0.02105305 & 149.62\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 1 × 29\n",
       "\n",
       "| <!--/--> | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | V10 &lt;dbl&gt; | ⋯ ⋯ | V20 &lt;dbl&gt; | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | -1.359807 | -0.07278117 | 2.536347 | 1.378155 | -0.3383208 | 0.4623878 | 0.2395986 | 0.0986979 | 0.363787 | 0.09079417 | ⋯ | 0.2514121 | -0.01830678 | 0.2778376 | -0.1104739 | 0.06692807 | 0.1285394 | -0.1891148 | 0.1335584 | -0.02105305 | 149.62 |\n",
       "\n"
      ],
      "text/plain": [
       "  V1        V2          V3       V4       V5         V6        V7       \n",
       "1 -1.359807 -0.07278117 2.536347 1.378155 -0.3383208 0.4623878 0.2395986\n",
       "  V8        V9       V10        ⋯ V20       V21         V22       V23       \n",
       "1 0.0986979 0.363787 0.09079417 ⋯ 0.2514121 -0.01830678 0.2778376 -0.1104739\n",
       "  V24        V25       V26        V27       V28         Amount\n",
       "1 0.06692807 0.1285394 -0.1891148 0.1335584 -0.02105305 149.62"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 1 × 29</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>V10</th><th scope=col>⋯</th><th scope=col>V20</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>3</th><td>-1.358354</td><td>-1.340163</td><td>1.773209</td><td>0.3797796</td><td>-0.5031981</td><td>1.800499</td><td>0.791461</td><td>0.2476758</td><td>-1.514654</td><td>0.2076429</td><td>⋯</td><td>0.5249797</td><td>0.2479982</td><td>0.7716794</td><td>0.9094123</td><td>-0.689281</td><td>-0.3276418</td><td>-0.1390966</td><td>-0.05535279</td><td>-0.05975184</td><td>378.66</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 1 × 29\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & V10 & ⋯ & V20 & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t3 & -1.358354 & -1.340163 & 1.773209 & 0.3797796 & -0.5031981 & 1.800499 & 0.791461 & 0.2476758 & -1.514654 & 0.2076429 & ⋯ & 0.5249797 & 0.2479982 & 0.7716794 & 0.9094123 & -0.689281 & -0.3276418 & -0.1390966 & -0.05535279 & -0.05975184 & 378.66\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 1 × 29\n",
       "\n",
       "| <!--/--> | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | V10 &lt;dbl&gt; | ⋯ ⋯ | V20 &lt;dbl&gt; | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 3 | -1.358354 | -1.340163 | 1.773209 | 0.3797796 | -0.5031981 | 1.800499 | 0.791461 | 0.2476758 | -1.514654 | 0.2076429 | ⋯ | 0.5249797 | 0.2479982 | 0.7716794 | 0.9094123 | -0.689281 | -0.3276418 | -0.1390966 | -0.05535279 | -0.05975184 | 378.66 |\n",
       "\n"
      ],
      "text/plain": [
       "  V1        V2        V3       V4        V5         V6       V7       V8       \n",
       "3 -1.358354 -1.340163 1.773209 0.3797796 -0.5031981 1.800499 0.791461 0.2476758\n",
       "  V9        V10       ⋯ V20       V21       V22       V23       V24      \n",
       "3 -1.514654 0.2076429 ⋯ 0.5249797 0.2479982 0.7716794 0.9094123 -0.689281\n",
       "  V25        V26        V27         V28         Amount\n",
       "3 -0.3276418 -0.1390966 -0.05535279 -0.05975184 378.66"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 1 × 29</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>V10</th><th scope=col>⋯</th><th scope=col>V20</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>-3.043541</td><td>-3.157307</td><td>1.088463</td><td>2.288644</td><td>1.359805</td><td>-1.064823</td><td>0.3255743</td><td>-0.06779365</td><td>-0.2709528</td><td>-0.8385866</td><td>⋯</td><td>2.102339</td><td>0.6616959</td><td>0.4354772</td><td>1.375966</td><td>-0.2938032</td><td>0.279798</td><td>-0.1453617</td><td>-0.2527731</td><td>0.03576423</td><td>529</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 1 × 29\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & V10 & ⋯ & V20 & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & -3.043541 & -3.157307 & 1.088463 & 2.288644 & 1.359805 & -1.064823 & 0.3255743 & -0.06779365 & -0.2709528 & -0.8385866 & ⋯ & 2.102339 & 0.6616959 & 0.4354772 & 1.375966 & -0.2938032 & 0.279798 & -0.1453617 & -0.2527731 & 0.03576423 & 529\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 1 × 29\n",
       "\n",
       "| <!--/--> | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | V10 &lt;dbl&gt; | ⋯ ⋯ | V20 &lt;dbl&gt; | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | -3.043541 | -3.157307 | 1.088463 | 2.288644 | 1.359805 | -1.064823 | 0.3255743 | -0.06779365 | -0.2709528 | -0.8385866 | ⋯ | 2.102339 | 0.6616959 | 0.4354772 | 1.375966 | -0.2938032 | 0.279798 | -0.1453617 | -0.2527731 | 0.03576423 | 529 |\n",
       "\n"
      ],
      "text/plain": [
       "  V1        V2        V3       V4       V5       V6        V7       \n",
       "1 -3.043541 -3.157307 1.088463 2.288644 1.359805 -1.064823 0.3255743\n",
       "  V8          V9         V10        ⋯ V20      V21       V22       V23     \n",
       "1 -0.06779365 -0.2709528 -0.8385866 ⋯ 2.102339 0.6616959 0.4354772 1.375966\n",
       "  V24        V25      V26        V27        V28        Amount\n",
       "1 -0.2938032 0.279798 -0.1453617 -0.2527731 0.03576423 529   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 1 × 29</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>V1</th><th scope=col>V2</th><th scope=col>V3</th><th scope=col>V4</th><th scope=col>V5</th><th scope=col>V6</th><th scope=col>V7</th><th scope=col>V8</th><th scope=col>V9</th><th scope=col>V10</th><th scope=col>⋯</th><th scope=col>V20</th><th scope=col>V21</th><th scope=col>V22</th><th scope=col>V23</th><th scope=col>V24</th><th scope=col>V25</th><th scope=col>V26</th><th scope=col>V27</th><th scope=col>V28</th><th scope=col>Amount</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>4</th><td>-1.863756</td><td>3.442644</td><td>-4.46826</td><td>2.805336</td><td>-2.118412</td><td>-2.332285</td><td>-4.261237</td><td>1.701682</td><td>-1.439396</td><td>-6.999907</td><td>⋯</td><td>0.360924</td><td>0.6679266</td><td>-0.5162424</td><td>-0.01221781</td><td>0.0706137</td><td>0.05850447</td><td>0.3048828</td><td>0.4180125</td><td>0.2088583</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 1 × 29\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & V1 & V2 & V3 & V4 & V5 & V6 & V7 & V8 & V9 & V10 & ⋯ & V20 & V21 & V22 & V23 & V24 & V25 & V26 & V27 & V28 & Amount\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t4 & -1.863756 & 3.442644 & -4.46826 & 2.805336 & -2.118412 & -2.332285 & -4.261237 & 1.701682 & -1.439396 & -6.999907 & ⋯ & 0.360924 & 0.6679266 & -0.5162424 & -0.01221781 & 0.0706137 & 0.05850447 & 0.3048828 & 0.4180125 & 0.2088583 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 1 × 29\n",
       "\n",
       "| <!--/--> | V1 &lt;dbl&gt; | V2 &lt;dbl&gt; | V3 &lt;dbl&gt; | V4 &lt;dbl&gt; | V5 &lt;dbl&gt; | V6 &lt;dbl&gt; | V7 &lt;dbl&gt; | V8 &lt;dbl&gt; | V9 &lt;dbl&gt; | V10 &lt;dbl&gt; | ⋯ ⋯ | V20 &lt;dbl&gt; | V21 &lt;dbl&gt; | V22 &lt;dbl&gt; | V23 &lt;dbl&gt; | V24 &lt;dbl&gt; | V25 &lt;dbl&gt; | V26 &lt;dbl&gt; | V27 &lt;dbl&gt; | V28 &lt;dbl&gt; | Amount &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 4 | -1.863756 | 3.442644 | -4.46826 | 2.805336 | -2.118412 | -2.332285 | -4.261237 | 1.701682 | -1.439396 | -6.999907 | ⋯ | 0.360924 | 0.6679266 | -0.5162424 | -0.01221781 | 0.0706137 | 0.05850447 | 0.3048828 | 0.4180125 | 0.2088583 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  V1        V2       V3       V4       V5        V6        V7        V8      \n",
       "4 -1.863756 3.442644 -4.46826 2.805336 -2.118412 -2.332285 -4.261237 1.701682\n",
       "  V9        V10       ⋯ V20      V21       V22        V23         V24      \n",
       "4 -1.439396 -6.999907 ⋯ 0.360924 0.6679266 -0.5162424 -0.01221781 0.0706137\n",
       "  V25        V26       V27       V28       Amount\n",
       "4 0.05850447 0.3048828 0.4180125 0.2088583 1     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I go on to filter different parts of my dataset\n",
    "data_1 <- test_dataset %>% select(-30) \n",
    "data_2 <- test_dataset %>% filter(Class == 1) %>% select(-30)\n",
    "\n",
    "#Cases that are confirmed as not fraud (without the Class variable)\n",
    "data1 <- data.frame(data_1[1,])\n",
    "data2 <- data.frame(data_1[2,])\n",
    "data3 <- data.frame(data_1[3,])\n",
    "data4 <- data.frame(data_1[4,])\n",
    "\n",
    "#Cases that are confirmed as fraud (without the Class variable)\n",
    "data5 <- data.frame(data_2[1,])\n",
    "data6 <- data.frame(data_2[2,])\n",
    "data7 <- data.frame(data_2[3,])\n",
    "data8 <- data.frame(data_2[4,])\n",
    "\n",
    "data1\n",
    "data2\n",
    "data5\n",
    "data8\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "15afd720",
   "metadata": {
    "papermill": {
     "duration": 0.015817,
     "end_time": "2022-12-10T13:18:37.681868",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.666051",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Model testing proper\n",
    "I begin to feed the smaller datasets into my model to determine eitther fraud or not. I have estimated a percetage above 50 as fraud and below 50 as not fraud.I have tweaked my model to return TRUE for fradulent transactions and FALSE for otherwise."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "022afa6e",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:37.700558Z",
     "iopub.status.busy": "2022-12-10T13:18:37.698842Z",
     "iopub.status.idle": "2022-12-10T13:18:37.749728Z",
     "shell.execute_reply": "2022-12-10T13:18:37.748496Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.062221,
     "end_time": "2022-12-10T13:18:37.751782",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.689561",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<strong>1:</strong> FALSE"
      ],
      "text/latex": [
       "\\textbf{1:} FALSE"
      ],
      "text/markdown": [
       "**1:** FALSE"
      ],
      "text/plain": [
       "    1 \n",
       "FALSE "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<strong>1:</strong> FALSE"
      ],
      "text/latex": [
       "\\textbf{1:} FALSE"
      ],
      "text/markdown": [
       "**1:** FALSE"
      ],
      "text/plain": [
       "    1 \n",
       "FALSE "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<strong>3:</strong> FALSE"
      ],
      "text/latex": [
       "\\textbf{3:} FALSE"
      ],
      "text/markdown": [
       "**3:** FALSE"
      ],
      "text/plain": [
       "    3 \n",
       "FALSE "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<strong>2:</strong> FALSE"
      ],
      "text/latex": [
       "\\textbf{2:} FALSE"
      ],
      "text/markdown": [
       "**2:** FALSE"
      ],
      "text/plain": [
       "    2 \n",
       "FALSE "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<strong>3:</strong> TRUE"
      ],
      "text/latex": [
       "\\textbf{3:} TRUE"
      ],
      "text/markdown": [
       "**3:** TRUE"
      ],
      "text/plain": [
       "   3 \n",
       "TRUE "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "answer <- predict(model , data1 , type = \"response\") > 0.5\n",
    "answer\n",
    "\n",
    "answer1 <- predict(model , data5 , type = \"response\") >0.5\n",
    "answer1\n",
    "\n",
    "answer2 <- predict(model , data2 , type = \"response\") >0.5\n",
    "answer2\n",
    "\n",
    "answer3 <- predict(model , data6 , type = \"response\") >0.5\n",
    "answer3\n",
    "\n",
    "answer4 <- predict(model , data7 , type = \"response\") >0.5\n",
    "answer4"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8da785c6",
   "metadata": {
    "papermill": {
     "duration": 0.007648,
     "end_time": "2022-12-10T13:18:37.767287",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.759639",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Summary\n",
    "From the testing above, we have five(5) observations tested and a 100% accuracy but accuracy cannot be determined from just 5 observations out of  hundreds of thousands, so we carry on with more testing."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "26b2e8dc",
   "metadata": {
    "_kg_hide-output": true,
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:37.786735Z",
     "iopub.status.busy": "2022-12-10T13:18:37.785290Z",
     "iopub.status.idle": "2022-12-10T13:18:37.863236Z",
     "shell.execute_reply": "2022-12-10T13:18:37.860999Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.090182,
     "end_time": "2022-12-10T13:18:37.865637",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.775455",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "      Predicted\n",
       "Actual FALSE  TRUE\n",
       "     0 56867     9\n",
       "     1    35    50"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "reg_model <- predict(model , test_dataset , type =\"response\")\n",
    "\n",
    "table(Actual = test_dataset$Class , Predicted = reg_model> 0.5)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dcdd3706",
   "metadata": {
    "papermill": {
     "duration": 0.010576,
     "end_time": "2022-12-10T13:18:37.887492",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.876916",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Test Summary\n",
    "From above, the table(confusion matrix) shows the values being predicted; values ranging from TRUE-TRUE combination to FALSE-FALSE.To get the accuracy we get the ratio of sum of the left diagonal to the total sum of the table."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "cc41c2db",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-10T13:18:37.912683Z",
     "iopub.status.busy": "2022-12-10T13:18:37.911109Z",
     "iopub.status.idle": "2022-12-10T13:18:37.931714Z",
     "shell.execute_reply": "2022-12-10T13:18:37.929856Z"
    },
    "papermill": {
     "duration": 0.035968,
     "end_time": "2022-12-10T13:18:37.933716",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.897748",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "99.91"
      ],
      "text/latex": [
       "99.91"
      ],
      "text/markdown": [
       "99.91"
      ],
      "text/plain": [
       "[1] 99.91"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#accuracy of model\n",
    "accuracy <- (56839 + 73) / (56839 + 73 + 45 + 4)\n",
    "accuracy <- round((accuracy * 100),2)\n",
    "accuracy"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6477268e",
   "metadata": {
    "papermill": {
     "duration": 0.008502,
     "end_time": "2022-12-10T13:18:37.951501",
     "exception": false,
     "start_time": "2022-12-10T13:18:37.942999",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Summary\n",
    "The accuracy of our model turns out to be 99.9% which is a very good percentage and goes to show that this model can be adopted."
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
   "duration": 79.317148,
   "end_time": "2022-12-10T13:18:38.080520",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-12-10T13:17:18.763372",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
