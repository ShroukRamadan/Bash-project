#--------------------------Create Database-----------------------------------------------



function createDb(){
    pwd

    read -p "Enter DataBase Name You Want To Create : " name 

    if [[ $name = "" ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue

    #------with space or contain spectial character
    #elif [[ $name = *[ "~" "!" "@"  "$" "%" "^" "&" "*" "">" "<" "?" "L" ":" "'" "{" "}" '"' "|" ]* ]]
    # elif [ $name != *[ " " ]* ];then
    #     echo -e "\033[41m Database Name can't contain Spaces \033[m" #red
   #----------------------------    
    
    elif [ -e $name ];then 
        echo -e "\033[43m Sorry Please Enter Another Name This Is Exist ~_~ \033[m" #yellow

    elif [[ $name =~ ^[a-zA-Z] ]];then
        mkdir $name
        echo -e "\033[42m DataBase Created Sucessfully ^_^ \033[m" #green
    else
        echo -e "\033[41m Database Name can't start with numbers or special characters \033[m" #red
    fi
    echo "------------------"
                        
}

#-------------------------Drop database-------------------------------------------------


function dropDB(){

    read -p "Enter DataBase Name You Want To Drop : "  ddb 
    if [[ $ddb = "" ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct name \033[m" #blue

    elif [ -d $ddb ];then
        echo "You will drop $ddb, Okay?"
        select i in Yes No 
        do
            case $i in
            Yes ) 
                rm -rf $ddb
                echo -e "\033[42m DataBase Dropped Sucessfully \033[m"  #green
                break
            ;;
            No )
                echo -e "\033[43m Dropp Cancel \033[m"  #yellow
                break
            esac
                            
         done
    elif ! [ -d $ddb ];then
        echo -e "\e[41m This DataBase Doesn't Exist \e[0m"
                     
                    
    fi
    echo "------------------"
                  
}



#-------------------------List database-------------------------------------------------


function listDB(){

    pwd
    ls -F | grep "/"
    echo "------------------"
    #break
}


#-------------------------connect database-------------------------------------------------


function connectDB(){

    read -p "Enter DataBase Name You Want To Connect : " name 
    if [ -d $name ] ; then 
        cd ./$name                     
        pwd
        echo -e "\033[42m Connection Done Sucessfully \033[m"  #green
        echo "------------------"
        secondScreen;        
        #-----------------------------

    else 
        echo -e " \033[41m Sorry DataBase Not Exit \033[m"
        
    fi


}
#---------------------------Ask for MetaData----------------------------------------------

function metaData(){

    read -p "Enter Number of Colunms You Want: " $numCol

}


#---------------------------Create Table--------------------------------------------------

function createTB(){
                
                read -p "Enter Table Name You Want To Create : " Tbname 
                if [[ $Tbname = "" ]];then
                    echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue

                
                elif [ -e $Tbname ];then 
                    echo -e "\033[43m Sorry Please Enter Another Name This Is Exist ~_~ \033[m" #yellow
                
                elif [[ $Tbname =~ ^[a-zA-Z] ]];then
                    touch $Tbname
                    touch metadata_$Tbname
                    echo -e "\033[42m Table Created  Sucessfully ^_^ \033[m" #green

                else
                    echo -e "\033[41m Table Name can't start with numbers or special characters \033[m" #red
                fi
                    echo "------------------"

}


#------------------------------------Drop Table----------------------------

function dropTB(){

    read -p "Enter Table Name You Want To Drop : "  ddt 
    if [[ $ddt = "" ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue

    elif [ -f $ddt ];then
        echo "You will drop $ddt, Okay?"
        select i in Yes No 
        do
            case $i in
            Yes ) 
                rm $ddt
                rm metadata_$ddt
                echo -e "\033[42m Table Dropped Sucessflly \033[m"  #green
                break
            ;;
            No )
                echo -e "\033[43m Drop Canceled \033[m"  #yellow
                break
            esac                            
         done

    elif ! [ -f $ddt ];then
        echo -e "\e[41m This Table Doesn't Exist\e[0m"
                                         
    fi

    echo "------------------"
}


#------------------------List Tables--------------------------


function listTB(){

    ls -p  |grep -v '_' 
    echo "------------------"
}



#--------------Main Menu----------------------------------


function mainMenu(){



    EXIT="0"
    while [[ $EXIT != "1" ]] 
    do  
        select i in CreateDB ListDB ConnectDB DropDB Exit
        do
            case $i in
            
                CreateDB )

                    createDb;


                ;;
    
                #-------------------------------------------------------
                DropDB )

                    dropDB;
                        
                
                ;;
                #-------------------------------------------------------------
                ListDB )

                    listDB;
                        
                ;;
                #----------------------------------------------
                ConnectDB )
                    
                    connectDB;
                    
                ;;
                #---------------------------------------
                Exit )
                    EXIT="1"
                    echo "Exit"
                    break

                ;;

                *)
                  echo -e "\033[41m Wrong Choice, Please Enter Number From 1 to 5 : \033[m" #red
                  
                ;;
                esac
        done
    done


}




#--------------------------------Second screen-------------------------------

function secondScreen(){

    Back=0

    while (( $Back != 1 )) 
    do  

        select i in  CreateTB  DropTB ListTB InsertInTB  SelectFromTB  DeleteFromTB  UpdateFromTB Back
        do
            case $i in
            
                CreateTB )
                
                createTB;

                ;;
    
                #-------------------------------------------------------
                DropTB )

                dropTB;
                ;;
                #-------------------------------------------------------------
                ListTB )
                    
                    listTB;


                ;;

                InsertInTB )

                        
                ;;
                #----------------------------------------------
                SelectFromTB )
                    
                    
                ;;
                #---------------------------------------
                DeleteFromTB )
                    
                    
                ;;
                #---------------------------------------
                UpdateFromTB )

                ;;
                #----------------------------------------
                Back )
                Back=1
                cd ..
                mainMenu;
                
                ;;
                *)
                  echo -e "\033[41m Wrong Choice, Please Enter Number From 1 to 8 : \033[m" #red
                  
                ;;
            esac
        done
        
    done

}



######################################################################################################

#-------------Main Program---------------

   if [ -d ./DBMS ];then
       cd ./DBMS
       mainMenu;
       

    else
       mkdir ./DBMS
       cd ./DBMS
       mainMenu;
          
    fi


