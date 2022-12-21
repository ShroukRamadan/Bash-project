EXIT="0"
while [ $EXIT != "1" ] 
do  
    select i in CreateDB ListDB ConnectDB DropDB Exit
    do
        case $i in
        
            CreateDB )
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
                    break
                    
            ;;
            #-------------------------------------------------------
            DropDB )
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
                    break
                  
            
            ;;
            #-------------------------------------------------------------
            ListDB )
                    ls -F | grep "/"
                    echo "------------------"
                    break
            ;;
            #----------------------------------------------
            ConnectDB )
                read -p "Enter DataBase Name You Want To Connect : " name 
                if [ -d $name ] ; then 
                    cd $name 
                    pwd
                    cd ..
                else 
                  echo "Sorry DataBase Not Exit"
                fi
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