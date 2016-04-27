(define (domain WORLD)
    (:requirements :strips :typing :action-cost);; require STRIPS
    (:types crate content location person uav)
    (:predicates
        ;expressions for checks
        (free ?h)
        (at ?o ?l)
        (has ?o ?t)
    )

    (:functions
        (total-cost) - number
        (fly-cost ?from ?to -location) - number
    )

    (:constants
        ;food medicine - content
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
                     )
    )

;; CARRIER interactions
   (action: load-crate
            :parameters (?uav - uav
                        ?crate - crate
                        ?location - location
                        ?carrier - carrier)
            :precondition (and
                          ;location confirmation
                          (at ?uav ?location)
                          (at ?carrier ?location)

                          ;uav has crate
                          (has ?uav ?crate)
            )
            :effect (and
                    ; load crate
                    (has ?carrier ?crate)
                    (not (has ?uav ?crate))
            )
   )

   (action: unload_crate
            :parameters (?uav - uav
                        ?crate - crate
                        ?location - location
                        ?carrier - carrier)
            :preconditions (and
                           ;location confirmation
                           (at ?uav ?location)
                           (at ?carrier ?location)

                           ;uav can carry crate
                           (free ?uav)
            )
            :effect (and
                    (not (free ?uav))
                    (has ?uav ?crate)
                    (
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
