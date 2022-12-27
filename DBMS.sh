#--------------------------Create Database-----------------------------------------------



function createDb(){
    

    read -p "Enter DataBase Name You Want To Create : " DbName 

    if [[ $DbName = "" ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue

    elif [[ $DbName =~ *[/.:\|\-$%*';']* ]]; then
		echo -e "\e[41m DataBase Name can't contain special characters => /.:\|\-$%*; \e[0m"
    
    elif [[ $Tbname == *" "* ]];then
        echo -e "\033[41m DataBase Name can't contain spaces \033[m" #red
   #----------------------------    
    
    elif [ -e $DbName ];then 
        echo -e "\033[43m Sorry Please Enter Another Name This Is Exist ~_~ \033[m" #yellow

    elif [[ $DbName =~ ^[a-zA-Z] ]];then
        mkdir $DbName
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

    
    ls -F | grep "/"
    echo "------------------"
    #break
}


#-------------------------connect database-------------------------------------------------


function connectDB(){

    read -p "Enter DataBase Name You Want To Connect : " name 
    
    if [[ $name = "" ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue

    #-----------------------

    elif [ -d $name ] ; then 
        cd ./$name                     
        pwd
        echo -e "\033[42m Connection Done Sucessfully ^_^ \033[m"  #green
        echo "------------------"
        secondScreen;
        #PS3= "$name >>"        
        #-----------------------------
    else 
        echo -e " \033[41m Sorry DataBase Not Exist \033[m"
        
    fi


}


#---------------------------Create Table--------------------------------------------------

function createTB(){

                
    read -p "Enter Table Name You Want To Create : " Tbname 
    if [[ $Tbname = "" ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue
    
    
    elif [ -e $Tbname ];then 
        echo -e "\033[43m Sorry Please Enter Another Name This Is Exist ~_~ \033[m" #

    # elif [[ $Tbname == $DbName ]];then
    #     echo -e "\033[43m Sorry It's Name of DataBase, Please Enter Another  ~_~ \033[m" #
        
    elif [[ $Tbname == *" "* ]];then
        echo -e "\033[41m Table Name Can't Contain Spaces \033[m" #red
        
    
    elif [[ $Tbname =~ ^[a-zA-Z] ]];then
        

        touch $Tbname
        touch metadata_$Tbname

        read -p "Enter Number Of Columns You Want : " colsNum
        if [[ $colsNum = "" ]];then
            echo -e "\033[44m Null Entry,Please Enter a Number Only \033[m" #blue
        elif [[ $colsNum =~ ^[a-zA-Z] ]];then
            echo -e "\e[41m Please Enter a Number Only \e[0m" #red
        elif [[ $colsNum =~ [/.:\|\-$%*';'] ]];then
		    echo -e "\e[41m Please Enter a Number Only \e[0m"
        fi
        
        delimeter=":"
        lineDel="\n"
        pk=""

        metaData="ColumName"$delimeter"DataType"$delimeter"PrimaryKey"


        if [[ $colsNum = [0-9] ]];then
                
            
            for ((i=1 ;i<=$colsNum; (i++) ))
            do
                read -p "Name of Column No.$i: " colName
                if [[ $colName = "" ]];then
                    echo -e "\033[44m Null Entry,Please Enter a Correct Name \033[m" #blue
                    break
                elif [[ $colName =~ [0-9] ]];then
                     echo -e "\e[41m Please Enter a Number Only \e[0m" #red
                     break
                elif [[ $colName =~ [/.:\|\-$%*';'] ]];then
		            echo -e "\e[41m Please Enter a Number Only \e[0m"
                    break
                fi
                
                echo -e "Type of Column $colName: "
                select ch in INT STR
                do
                    case $ch in
                        INT )
                        colType="int";
                        break                               
                        ;;
                        STR ) 
                        colType="str";
                        break
                        ;;
                        # * )
                        # echo -e "\033[41m Wrong Choice, Please Enter Number 1 OR 2: \033[m" #red
                        # ;;
                    esac
                done
                
                if [[ $pk == "" ]]; then
                    echo -e "Make PrimaryKey ? "
                    select choice in YES NO
                    do
                        case $choice in
                        YES ) 
                        pk="PK";
                        metaData+=$lineDel$colName$delimeter$colType$delimeter$pk;
                        break
                        ;;
                        
                        NO )
                            metaData+=$lineDel$colName$delimeter$colType$delimeter""
                        break
                        ;;
                        
                        * ) 
                        echo -e "\033[41m Wrong Choice, Please Enter Number 1 OR 2 : \033[m" #red
                        esac
                    done
                else
                    metaData+=$rSep$colName$sep$colType$sep""
                fi
                
                if [[ $count == $colsNum ]]; then
                    temp=$temp$colName
                else
                    temp=$temp$colName$sep
                fi
            done
            
            echo -e $metaData  >> metadata_$Tbname
            echo -e $temp >> $Tbname
            if [[ $? == 0 ]];then
                echo -e "\033[42m Table Created  Sucessfully ^_^ \033[m" #green
                secondScreen;

            fi

        

        fi      

    else
        echo -e "\033[41m Table Name can't start with numbers or special characters \033[m" #red
    fi
    echo "------------------"


}

#-------------------------------------------------------------------------


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

#------------------------select Tables--------------------------
function selectTB(){
        read -p "Please Enter Table Name : " Tbname
        
        if [[ $Tbname = "" ]];then
                echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue
        
        elif ! [ -f $Tbname ];then
                echo -e "\e[41m This Table Doesn't Exist\e[0m"
        
        elif [ -f $Tbname ];then
        EXIT="0"
        while [[ $EXIT != "1" ]] 
            do
                select i in All ById ByColumn Exit
                   do
                       case $i in
                        All ) 
                           cat $Tbname
                           break
                        ;;
                        ById )
                           read -p "Please Enter ID : " ID
                           cat $Tbname |  awk -v ID=$ID -F ":" '$1==ID { print $0 }'
                           break
                        ;;
                        ByColumn )

                            read -p "Please Enter column name : " col
                            
                            cat $Tbname |  awk -F ":" '{ print $2 }'    
                        ;;
                    

                       Exit )
                           EXIT="1"
                           echo "Exit"
                            break
                       ;;   
                       esac
                                       
                    done
            done
        fi

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

    Back="0"

    while [[ $Back != "1" ]]  
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
                    
                    selectTB;
                ;;
                #---------------------------------------
                DeleteFromTB )
                    
                    
                ;;
                #---------------------------------------
                UpdateFromTB )

                ;;
                #----------------------------------------
                Back )
                    Back="1"
                    echo "Back"
                    cd ..
                    break
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


