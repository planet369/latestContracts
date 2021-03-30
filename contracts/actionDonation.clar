(define-constant contractPrincipal (as-contract tx-sender))

(define-read-only (get-contract-principle) 
    (ok contractPrincipal)
)

(define-map actions_donations {action_name: (string-utf8 256),  action_small_description: (string-utf8 256), action_id: (string-utf8 256), action_owner: principal} {ardkonLira: uint, ardkonUSD: uint, stacks: uint})
(define-private (setInitial)
   (begin (map-set actions_donations {action_name: u"on create trial action",  action_small_description: u"on create trial action description", action_id: u"action_id", action_owner: tx-sender} {ardkonLira: u0, ardkonUSD: u0, stacks: u0})
 (ok u"value"))
     )
     
     (define-public (setInitialPublic)
   (begin (map-set actions_donations {action_name: u"on create trial action",  action_small_description: u"on create trial action description", action_id: u"action_id", action_owner: tx-sender} {ardkonLira: u0, ardkonUSD: u0, stacks: u0})
 (ok u"value"))
     )
 


(define-read-only (get-initial-map) 
    (let (
        (get-initial (map-get? actions_donations {action_name: u"on create trial action",  action_small_description: u"on create trial action description", action_id: u"action_id", action_owner: tx-sender}))
        ) (ok get-initial))
    
   
)