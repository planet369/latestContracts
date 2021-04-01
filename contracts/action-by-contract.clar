(define-constant actionAddress (as-contract tx-sender) )
;; Define the action address which is the same as the smart contract 

;;This contract will explain a contract that will act as one action where each action exposed will create this action for it. 

(define-fungible-token ardkonLira u125)

(define-data-var action-name (string-utf8 256) u"action-name")
(define-data-var action-id (string-utf8 256) u"action-id")
(define-data-var action-small-description (string-utf8 256) u"action-small-description")



(define-map fund-registry { action_id: (string-utf8 256), donor-name: (string-utf8 256), donor-country: (string-utf8 256), donor-email: (string-utf8 256)} { donation-currency: (string-utf8 256), amount: uint})

(define-map fund-allocation { action_id: (string-utf8 256), fund_name: (string-utf8 256), fund_owner: (string-utf8 256), fund_reciever_principal: principal, fund_paid: bool} { ardkonUSD: uint, ardkonStacks: uint})

(define-map fund_reciepts  { action_id: (string-utf8 256), fund_name: (string-utf8 256), reciept_id: (string-utf8 256), reciept_owner: principal, recieved: bool  } {ardkonUSD: uint, ardkonStacks: uint})

(define-map total_fund  { action_id: (string-utf8 256)} { ardkonUSD: uint, ardkonStacks: uint})
(define-map total_fund_collected  { action_id: (string-utf8 256)} { ardkonUSD: uint, ardkonStacks: uint})



(define-data-var (fund-list (list 750 { action_id: u"(string-utf8 256)", donor-name: u"(string-utf8 256)", donor-country: u"(string-utf8 256)", donor-email: u"(string-utf8 256)", donation-currency: u"(string-utf8 256)", amount: u10} )) 


(define-public (fund-action-dollars (action_id (string-utf8 256)) (donor-name (string-utf8 256)) (donor-country (string-utf8 256)) (donor-email (string-utf8 256))  (amount uint) ) 
    ;; in this function we should transfer funds from sender to contract
    ;; we should add the info to the map and to the list 
    (begin 
        (map-insert fund-registry { action_id: action_id, donor-name: donor-name, donor-country: donor-country, donor-email: donor-email} { donation-currency: u"ardkonUSD", amount: amount})
        
   )

)


(define-public (add-fund-allocation) 
;; let the action-id owner add fund allocation to his action 
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (delete-fund-allocation) 
;; let the action-id owner delete to his action 
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (publish-action) 
;; this will enable the user to loch the contract of fund allocation in this way change cannot be happened
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (add-reciepts) 
;; let fund owner to add his receipt
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (accept-reciepts) 
;; let the commity of donors and checkers to accept the reciepts presented
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (submit-proof-of-fund) 
;; submitting a proof of fund where it can be a link to an image
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (voting-on-fund-proof) 
;; submitting a proof of fund where it can be a link to an image
(begin (print "action_id")
    (ok "value")
  
    )
)

(define-public (collect-funds) 
;; let fund owner collect his funds upon aproval of the system with a valid reciept id
(begin (print "action_id")
    (ok "value")
  
    )
)
(define-public (return-funds) 
;; this happens if the actions fails to be submitted
(begin (print "action_id")
    (ok "value")
  
    )
)