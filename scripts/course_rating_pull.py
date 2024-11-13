# import libraries
import requests
import bs4 as bs
import pandas as pd
import os.path



# set course id
course_id_start = 0
end_id = 50000
course_id = 0
# create a list of courses
course_list = []
# create a list of course course tee info
tee_info = []

while (course_id_start < end_id):
    course_id = course_id_start
    # collect course info
    print(course_id)
    if course_id < 1000:
        sauce = requests.get('https://ncrdb.usga.org/courseTeeInfo?CourseID=' + str(course_id).zfill(4))
    else:
        sauce = requests.get('https://ncrdb.usga.org/courseTeeInfo?CourseID=' + str(course_id))
    type(sauce)
    sauce.text
    # create BeautifulSoup object
    soup = bs.BeautifulSoup(sauce.text, 'lxml')

    # if the title is not Course Rating and Slope Database™ then don't traverse page
    if 'National Course Rating Database' in soup.title.text:
        #print(soup.title.text)


        # save course info to list for saving to specific course info csv
        body = soup.body
        nameTable = body.find('table', id='gvCourseTees')
        if nameTable:
            course_name_entries = nameTable.find_all('td')
            course_name = course_name_entries[0].text
            course_city = course_name_entries[1].text
            course_state = course_name_entries[2].text


            course_list.append([course_id,course_name,course_city,course_state])


            # save tee info to list for saving to specific tee csv
            ratingTable = body.find('table', id='gvTee')
            if ratingTable:
                count_tr = 0
                for tr in ratingTable.find_all('tr'):
                    #print(tr.text)
                    if count_tr > 0:
                        count_td = 0
                        course_record = []
                        for td in tr.find_all('td'):
                            if count_td == 0:
                                course_record.append(course_id)
                            course_record.append(td.text)
                            count_td += 1

                        course_code = course_record[0]
                        tee_name = course_record[1]
                        gender = course_record[2]
                        par = course_record[3]
                        rating18 = course_record[4]
                        bogey18 = course_record[5]
                        slope18 = course_record[6]

                        f9_rating = course_record[7]
                        f9_slope = course_record[13]
                        b9_rating_slope = course_record[10].replace(" ","").split('/')
                        b9_rating = course_record[8]
                        b9_slope = "".join(b9_rating_slope[1].split())
                        tee_id = course_record[15]
                        yardage = course_record[16]
                        f9_bogey = course_record[11]
                        b9_bogey = course_record[12]
                        

                        tee_info.append([course_code,tee_name,gender,par,rating18,bogey18,slope18,f9_rating,f9_slope,b9_rating,b9_slope,tee_id,yardage,f9_bogey,b9_bogey])

                    count_tr += 1

    course_id_start += 1
#print(course_list)
#print(tee_info)

df_cl = pd.DataFrame(course_list, columns = ['course_id','course_name','course_city','course_state'])
df_ti = pd.DataFrame(tee_info, columns = ['course_id','tee_name','gender','par','rating','bogey_rating','slope','f9_rating','f9_slope','b9_rating','b9_slope','tee_id','yardage','f9_bogey','b9_bogey'])

#print(df_cl)
#print(df_ti)

x = 0
fname_cl = 'course_list-2024-'
fname_ti = 'tee_info-2024-'

while os.path.isfile(fname_cl + str(x) + '.csv') & os.path.isfile(fname_ti + str(x) + '.csv'):
   x += 1


df_cl.to_csv(fname_cl + str(x) + '.csv')
df_ti.to_csv(fname_ti + str(x) + '.csv')
print('DONE')
