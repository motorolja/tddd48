(define (domain WORLD)
    (:requirements :strips :typing :action-costs);; require STRIPS
    (:types crate content location person uav number carrier)
    (:predicates
        ;expressions for checks
        (free ?h)
        (at ?o ?l)
        (has ?o ?t)

        ;needed to check which is the next number for counting
        (next ?n ?n)
    )

    (:functions
        (total-cost) - number
        (fly-cost ?from ?to - location) - number
    )

    (:constants
        ;food medicine - content
        ;numbers for counting carrier load
        num0 num1 num2 num3 num4 - number
        depot - location
    )
    (:action deliver
        :parameters (?uav - uav
                     ?crate - crate 
                     ?content - content 
                     ?person - person 
                     ?location - location)
        :precondition (
                    and
                    ;location confirmation
                    (at ?uav ?location)
                    (at ?person ?location)

                    ;possession confirmation
                    (has ?uav ?crate)
                    (has ?crate ?content)
                    )
        :effect (and
                    ;giving crate
                    (not (has ?uav ?crate))
                    (free ?uav)
                    (has ?person ?content)
        
                    ;; # NOT NEEDED IN THIS LAB - result is that the
                    ;;   crate cannot be accessed anymore
                    ;(has ?person ?crate)

                    (increase (total-cost) 5)
            )
    )
    (:action move
        :parameters (?uav - uav
                     ?from - location
                     ?to - location)
        :precondition (and
                        ;location confirmation
                        (at ?uav ?from)
                     )
        :effect (and
                        ;moving uav
                        (not (at ?uav ?from))
                        (at ?uav ?to)
                        (increase (total-cost) (fly-cost ?from ?to))
                     )
    )
    (:action move-carrier
        :parameters (?uav - uav
                    ?carrier - carrier
                    ?from - location
                    ?to - location)
        :precondition (and
                        ;location confirmation
                        (at ?uav ?from)
                        (at ?carrier ?from)
                        ;uav not occupied
                        (free ?uav)
                      )
        :effect (and
                        ;moving uav
                        (not (at ?uav ?from))
                        (at ?uav ?to)
                        ;moving carrier
                        (not (at ?carrier ?from))
                        (at ?carrier ?to)
                        (increase (total-cost) (fly-cost ?from ?to))
                      )
    )

    (:action pick
        :parameters (?uav - uav
                     ?crate - crate
                     ?location - location)
        :precondition (and
                        ;location confirmation
                        (at ?uav ?location)
                        (at ?crate ?location)
                        (free ?uav)
                       )
        :effect (and
                        ;taking object
                        (not (at ?crate ?location))
                        (has ?uav ?crate)

                        ;setting uav as not free
                        (not (free ?uav))
                        (increase (total-cost) 5)
                     )
    )

;; CARRIER interactions
   (:action load-crate
            :parameters (?uav - uav
                        ?crate - crate
                        ?location - location
                        ?carrier - carrier
                        ?currentLoad - number
                        ?nextLoad    - number)
            :precondition (and
                          ;location confirmation
                          (at ?uav ?location)
                          (at ?carrier ?location)

                          ;uav has crate
                          (has ?uav ?crate)

                          ;carrier load confirmation
                          (has ?carrier ?currentLoad)
                          (next ?currentLoad ?nextLoad)
            )
            :effect (and
                    ; load crate
                    (has ?carrier ?crate)
                    (has ?carrier ?nextLoad)
                    (free ?uav)
                    (not (has ?uav ?crate))
                    (not (has ?carrier ?currentLoad))
                    (increase (total-cost) 5)
            )
   )

   (:action unload_crate
            :parameters (?uav - uav
                        ?crate - crate
                        ?location - location
                        ?carrier - carrier
                        ?currentLoad - number
                        ?nextLoad    - number)
            :precondition (and
                           ;location confirmation
                           (at ?uav ?location)
                           (at ?carrier ?location)

                           ;uav can carry crate
                           (free ?uav)

                          ;carrier has crate loaded on it
                          (has ?carrier ?crate)

                          ;carrier load confirmation
                          (has ?carrier ?currentLoad)
                          ;"currentLoad" should be next number of "nextLoad"
                          (next ?nextLoad ?currentLoad)
            )
            :effect (and
                    ;give the crate to the uav
                    (has ?uav ?crate)
                    (not (free ?uav))
                    ;remove crate from carrier
                    (not (has ?carrier ?crate))
                    ;change the load of the carrier
                    (not (has ?carrier ?currentLoad))
                    (has ?carrier ?nextLoad)
                    (increase (total-cost) 5)
            )
    )
    ;; ### NOT USED IN THIS LAB ###
;;    (
;;     :action drop
;;        :parameters (?uav - uav
;;                     ?crate - crate
;;                     ?location - location)
;;        :precondition (and
;;                        ;location confirmation
;;                        (at ?uav ?location)
;;
;;                        ;possession confirmation
;;                        (has ?uav ?crate)
;;                     )
;;        :effect (and
;;                        ;drop object
;;                        (at ?crate ?location)
;;                        (not (has ?uav ?crate))
;;
;;                        ;setting uav as free
;;                        (free ?uav)
;;                     )
;;    )
)
