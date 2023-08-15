import numpy as np
import pandas as pd
import module1 as m1


def drop_columns():
    ds = m1.rename_columns()
    # Method to drop unnecessary columns from the DataFrame.
    # Returns: DataFrame with specified columns dropped.
    col=['PatientId','AppointmentID','Neighbourhood']
    ds.drop(columns=col,axis=1,inplace=True)
    return ds


def create_bin():
    ds = drop_columns()
    #First Drop rows with Age == 0
    ds=ds[ds['Age']!=0]
    # Generating labels for age intervals (e.g., '1 - 20', '21 - 40', etc.)
    labels = ["{0} - {1}".format(i, i + 20) for i in range(1, 118, 20)]

    # Using the pd.cut() function to categorize ages into groups(use bins = range(1, 130, 20) 
    #,right=False and use the given labels)
    bin_age=[x for x in range(1,130,20)]
    ds['Age_group']=pd.cut(ds['Age'],bins=bin_age,labels=labels,right=False)
    # Returning the modified dataset with assigned age groups
    return ds


def drop():
    ds = create_bin()
    # Method to drop the original 'Age' column from the DataFrame.
    # Returns: DataFrame with the 'Age' column dropped.
    ds.drop(columns='Age',axis=1,inplace=True)
    return ds


def convert():
    ds = drop()
    # Method to convert 'NoShow' values into binary values (1 for 'Yes' and 0 for 'No').
    # Returns: DataFrame with 'NoShow' column values converted to 1s and 0s.
    def convert_show(text):
        if text=='Yes':
            return 1
        else:
            return 0
    
    ds['NoShow']=ds['NoShow'].apply(convert_show)
    return ds


def export_the_dataset():
    df = convert()
    # write your code to export the cleaned dataset and set the index=false and return the same as 'df'
    df.to_csv('patients.csv',index=False)
    #return df


# TASK 6: Load the Cleaned dataset 'patients.csv' to the database provided.
# follow the instruction in the Task 5 description and complete the task as per it.

# check if mysql table is created using "patients"
# Use this final dataset and upload it on the provided database for performing analysis in MySQL
# To run this task click on the terminal and click on the run project


def main():
    export_the_dataset()

if __name__=='__main__':
    main()