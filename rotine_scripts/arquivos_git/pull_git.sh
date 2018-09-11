#!/usr/bin/env bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # #
#   DEVELOPMENT BY    #
# # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#                                                                             #
#   If I have seen further it is by standing on the shoulders of Giants.      #
#                           ~Isaac Newton                                     #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
# Date create script:               [30/03/18]       #
# Last modification script:         [11/09/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# chamando arquivo de configuracao
source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/git.conf
#

pull_git()
{
    # data de inicio do script
    echo "Inicio do script" > /tmp/repo.txt
    date > /tmp/repo.txt
    printf "\n" >> /tmp/repo.txt

    # # walk to the array
    for (( i = 0; i <= ${#repos[@]}; i++ )); do 
        # verify local repo disk
        if [[ $local${repos[$i]} != $local ]]; then
            # verify local repo
            if [ -e "$local${repos[$i]}" ]; then         
                date >> /tmp/repo.txt
                echo "[+] - Update repositorie:" $local${repos[$i]} >> /tmp/repo.txt

                # into folder location
                cd $local${repos[$i]}

                # update repositories
                git pull >> /tmp/repo.txt

                # if update repositorie not work - exit 1
                # [[ $variavel -eq 1 ]] && echo "Repositorie Error ${repos[$i]}!" >> /tmp/repo.txt

                # mostrando mensagem de verificao
                [[ $? -eq 1 ]] && notify-send "Erro! Nao foi possivel sincronizar ${repos[$i]} com o servidor!" 
                # && exit 1 \
                                      # || notify-send "Repositorios ${repos[$i]} atualizado com o servidor!"

                # REPO_FOUNDS=$(($REPO_FOUNDS + 1));        
                let REPO_FOUNDS++       

                printf "\n" >> /tmp/repo.txt    
            else
                date >> /tmp/repo.txt
                echo "[-] - Not found": $local${repos[$i]}

                # REPO_NOTFOUNDS=$(($REPO_NOTFOUNDS + 1));        
                let REPO_NOTFOUNDS++
            fi
        fi
    done    

    # data do final do script
    date >> /tmp/repo.txt
}

pull_git