
et $FORNAX_CARD.card > /dev/null
if [[ "$?" != "0" ]]
then
    echo "Nao existe chaincode/business card: $FORNAX_CARD"
else
    etoutput $FORNAX_CARD.card > /dev/null
    composer card import --file ./$FORNAX_CARD.card --card $FORNAX_CARD
    pm2-docker composer-rest-server -c $FORNAX_CARD -n always -u true -d y -w true
fi
