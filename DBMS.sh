
#--------------------------Create Database--------------------------

function createDb(){

    read -p "Enter DataBase Name You Want To Create : " name 
    if [[ $name = "" ]];then
        echo -e "\033[44m null entry, please enter a correct name \033[m" #blue

   #----------------------------    
    elif [ -e $name ];then 
        echo -e "\033[43m Sorry Please Enter Another Name this Exist ~_~ \033[m" #yellow

   elif [[ $name =~ ^[a-zA-Z] ]];then
        mkdir $name
        echo -e "\033[42m DataBase Created ^_^ \033[m" #green
    else
        echo -e "\033[41m Database name can't start with numbers or special characters \033[m" #red
    fi
    echo "------------------"
    # break
                    
    
}

#-------------------------Drop database-------------------------------------------------


function dropDB(){

    read -p "Enter DataBase Name You Want To Drop : "  ddb 
    if [[ $ddb = "" ]];then
        echo -e "\033[44m null entry, please enter a correct name \033[m" #blue

    elif [ -d $ddb ];then
        echo "You will drop $ddb, Okay?"
        select i in Yes No 
        do
            case $i in
            Yes ) 
                rm -rf $ddb
                echo -e "\033[42m Done \033[m"  #green
                break
            ;;
            No )
                echo -e "\033[43m Not Deleted \033[m"  #yellow
                break
            esac
                            
         done
    elif ! [ -d $ddb ];then
        echo -e "\e[41mthis database doesn't exist\e[0m"
                     
                    
    fi
    echo "------------------"
    #break
                  
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
    if [ -d $name ] ; then 
        cd $name                     
        #cd ../$name
        pwd
        secondScreen;

    else 
        echo -e " \033[41m Sorry DataBase Not Exit \033[m"
        
                fi

}


#--------------------------------Second screen-------------------------------

function secondScreen(){

Back="0"

while [ $Back != "1" ] 
do  
    select i in  CreateTB  DropTB ListTB InsertInTB  SelectTB  DeleteFromTB  UpdateFromTB Back
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
            SelectTB )
                
                
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
              cd ..
              mainMenu;
              
            ;;
        esac
    
    done
done

}

#---------------------------Create Table-------------------

function createTB(){
                
                read -p "Enter Table Name You Want To Create : " Tbname 
                if [[ $Tbname = "" ]];then
                    echo -e "\033[44m null entry, please enter a correct name \033[m" #blue

                
                elif [ -e $Tbname ];then 
                    echo -e "\033[43m Sorry Please Enter Another Name this Exist ~_~ \033[m" #yellow
                
                elif [[ $Tbname =~ ^[a-zA-Z] ]];then
                    touch $Tbname
                    echo -e "\033[42m Table Created ^_^ \033[m" #green
                else
                    echo -e "\033[41m Table name can't start with numbers or special characters \033[m" #red
                fi
                    echo "------------------"

}


#------------------------------------Drop Table----------------------------

function dropTB(){

    read -p "Enter Table Name You Want To Drop : "  ddt 
    if [[ $ddt = "" ]];then
        echo -e "\033[44m null entry, please enter a correct name \033[m" #blue

    elif [ -f $ddt ];then
        echo "You will drop $ddt, Okay?"
        select i in Yes No 
        do
            case $i in
            Yes ) 
                rm $ddt
                echo -e "\033[42m Table Dropped Sucessflly \033[m"  #green
                break
            ;;
            No )
                echo -e "\033[43m Not Deleted \033[m"  #yellow
                break
            esac
                            
         done
    elif ! [ -d $ddb ];then
        echo -e "\e[41mthis database doesn't exist\e[0m"
                     
                    
    fi
    echo "------------------"
    #break
}


#------------------------List Tables--------------------------


function listTB(){

    ls 
    echo "------------------"
    #break
}



#--------------Main Menu----------------------------------
function mainMenu(){


    EXIT="0"
    while [ $EXIT != "1" ] 
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
                echo "Exit"
                EXIT="1"
                break
                ;;
                esac
        done
    done






}



######################################################################################################


mainMenu;
