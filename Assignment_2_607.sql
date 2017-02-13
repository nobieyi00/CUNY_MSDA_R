/*
This is a Microsoft SQL Server Database. To install please follow the instructions in the website below
https://msdn.microsoft.com/en-us/library/ms143219.aspx
*/

USE MyDb

Go

--Create table to Insert Movie Reviews Raw Data

IF OBJECT_ID (N'Movie_Reviews_Stage', N'U') IS NOT NULL 
  DROP TABLE [dbo].[Movie_Reviews_Stage]

GO

CREATE TABLE [dbo].[Movie_Reviews_Stage](
	[ID] [int] NULL,
	[Movie_Title] [varchar](40) NULL,
	[Reviewer_Name] [varchar](40) NULL,
	[Ratings] [smallint] NULL
) ON [PRIMARY]


/*
Please go the url https://raw.githubusercontent.com/nobieyi00/CUNY_MSDA_R/master/Movie_reviews.csv in order to 
download Movie Reviews csv file into your local drive. Please take note of your download path then so that it 
can be reference in the BULK INSERT

*/
--Bulk insert data from CSV file
BULK INSERT [dbo].[Movie_Reviews_Stage]
     FROM 'C:\Users\Mezue\Documents\Data607\Movie_reviews.csv'
	 WITH
	 (
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	 )
GO

SELECT * FROM [dbo].[Movie_Reviews_Stage]


GO

---Create Movie Table 
Select  ROW_NUMBER() over(order by Movie_Title) as Movie_ID, Movie_Title 
into dbo.Movies
From [dbo].[Movie_Reviews_Stage]
group by Movie_Title


--Few data in Movie Table
Select * from dbo.Movies

---Create Table for Reviews
Select  ROW_NUMBER() over(order by Reviewer_name) as Reviewer_ID, Reviewer_Name 
into dbo.Reviewer
From [dbo].[Movie_Reviews_Stage]
group by Reviewer_Name

Select * from dbo.Reviewer

--Create a cross reference table to show many to many relationship of a reviewer and Movie
Select ROW_NUMBER() over(order by R.Reviewer_ID) as ID, R.Reviewer_ID, M.Movie_ID, MR.Ratings 
into dbo.Movie_Review_Xref
from [dbo].[Movie_Reviews_Stage] MR
INNER JOIN dbo.Reviewer R ON MR.Reviewer_Name = R.Reviewer_Name
INNER JOIN dbo.Movies M on M.Movie_Title = MR.Movie_Title

select * from dbo.Movie_Review_Xref
