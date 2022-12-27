#!/usr/bin/bash


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
        export DBName=$name
        # $PS3="MySql@$name>>"
        # echo "$PS3"
        secondScreen;
             
        #-----------------------------
    else 
        echo -e " \033[41m Sorry DataBase Not Exist \033[m"
        
    fi


}


#---------------------------Create Table--------------------------------------------------

function createTB(){                
    read -p "Enter Table Name You Want To Create : " Tbname 
    if [[ $Tbname = " " ]];then
        echo -e "\033[44m Null Entry, Please Enter a Correct Name \033[m" #blue

    
    elif [ -e $Tbname ];then 
        echo -e "\033[43m Sorry Please Enter Another Name This Is Exist ~_~ \033[m" #

    elif [[ $Tbname == $DBName ]];then
        echo -e "\033[43m Sorry It's Name of DataBase, Please Enter Another  ~_~ \033[m" #
        
    elif [[ $Tbname == *" "* ]];then
        echo -e "\033[41m Table Name can't contain spaces \033[m" #red
        
    
    elif [[ $Tbname =~ ^[a-zA-Z] ]];then
               
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
        
        if [[ $colsNum =~ ^[1-90-9] ]];then        
            for ((i=1 ;i<=$colsNum; (i++) ))
            do
                read -p "Name of Column No.$i: " colName
                
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
                        * )
                        echo -e "\033[41m Wrong Choice, Please Enter Number 1 OR 2: \033[m" #red

                        ;;
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
                    metaData+=$lineDel$colName$delimeter$colType$delimeter""
                fi
                
                if [[ $count == $colsNum ]]; then
                    temp=$temp$colName
                else
                    temp=$temp$colName$delimeter
                fi
            done
            
            touch $Tbname  
            touch metadata_$Tbname
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


#---------------Insert Into Table----------------------

function insertInTB(){
    pwd
    read -p "Enter Table Name:" $tbname
    if [[ -z $tbname ]];then
        numCols=$( awk 'END{print NR-1}' metadata_$tbname )
        for (( i=1 ;i<=$numCols; (i++) ));
        do
             echo "x"
        done
    else
        echo -e " \033[41m Sorry Table Not Exist \033[m"

        



    fi


}



#--------------Main Menu----------------------------------


function mainMenu(){
    EXIT="0"
    while [[ $EXIT != "1" ]] 
    do 
        export PS3="MySql>>"
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

        PS3=$PS3"$DBName>>"
        #echo $PS3
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
                   insertInTB;

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
                    Back="1"
                    echo "Back"
                    cd ..
                    break
                    echo "------------------"
                    PS3="MySql>>"
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


