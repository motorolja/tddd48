(define (domain WORLD)
    (:requirements :typing :durative-actions)

    (:types 
        crate content location person num carrier vehicle - object
        uav robot - vehicle
    )
    (:predicates
        ;expressions for checks
        (free ?veh - vehicle)
        (at ?o - object ?l - location)
        (has ?o1 ?o2 - object)

        ;needed to check which is the next number for counting
        (next ?n ?m - num)
    )

    (:functions
        (fly-cost ?from ?to - location) - number
    )

    ;(:constants
    ;    ;food medicine - content
    ;    ;numbers for counting carrier load
    ;    num0 num1 num2 num3 num4 - num
    ;    depot - location
    ;)
    (:durative-action deliver
        :parameters (?veh - vehicle
                     ?crate - crate 
                     ?content - content 
                     ?person - person 
                     ?location - location)
        :duration (= ?duration 5)
        :condition (
                    and
                    ;location confirmation
                    (over all (at ?veh ?location))
                    (over all (at ?person ?location))

                    ;possession confirmation
                    (at start (has ?veh ?crate))
                    (over all (has ?crate ?content))
                    )
        :effect (and
                    ;giving crate
                    (at start (not (has ?veh ?crate)))
                    (at end (free ?veh))
                    (at end (has ?person ?content))
                )
    )
    (:durative-action move
        :parameters (?uav - uav
                     ?from - location
                     ?to - location)
        :duration (= ?duration 10)
        :condition (and
                        ;location confirmation
                        (at start (at ?uav ?from))
                     )
        :effect (and
                        ;moving uav
                        (at start (not (at ?uav ?from)))
                        (at end (at ?uav ?to))
                     )
    )
    (:durative-action move-carrier
        :parameters (?uav - uav
                    ?carrier - carrier
                    ?from - location
                    ?to - location)
        :duration (= ?duration 10)
        :condition (and
                        ;location confirmation
                        (at start (at ?uav ?from))
                        (at start (at ?carrier ?from))
                        ;uav not occupied
                        (at start(free ?uav))
                      )
        :effect (and
                        ; setting uav as not being free
                        (at start (not (free ?uav)))

                        ;removing start location
                        (at start (not (at ?uav ?from)))
                        (at start (not (at ?carrier ?from)))
                        ;adding end position
                        (at end (at ?uav ?to))
                        (at end (at ?carrier ?to))

                        ; setting uav as being free
                        (at end (free ?uav))
                      )
    )

;; VEHICLE actions
    (:durative-action pick
        :parameters (?veh - vehicle
                     ?crate - crate
                     ?location - location)
        :duration (= ?duration 5)
        :condition (and
                        ;location confirmation
                        (over all (at ?veh ?location))
                        (at start (at ?crate ?location))
                        (at start (free ?veh))
                       )
        :effect (and
                        ;taking object
                        (at start (not (at ?crate ?location)))
                        (at end (has ?veh ?crate))

                        ;setting vehicle as not free
                        (at start (not (free ?veh)))
                     )
    )

   (:durative-action load-crate
            :parameters (?veh - vehicle
                        ?crate - crate
                        ?location - location
                        ?carrier - carrier
                        ?currentLoad - num
                        ?nextLoad    - num)
            :duration (= ?duration 5) 
            :condition (and
                          ;location confirmation
                          (over all (at ?veh ?location))
                          (over all (at ?carrier ?location))

                          ;vehicle has crate
                          (at start (has ?veh ?crate))

                          ;carrier load confirmation
                          (at start (has ?carrier ?currentLoad))
                          (over all (next ?currentLoad ?nextLoad))
            )
            :effect (and
                    ; change the current load
                    (at start (not (has ?carrier ?currentLoad)))
                    (at start (has ?carrier ?nextLoad))

                    ; remove the crate from vehicle
                    (at start (not (has ?veh ?crate)))

                    ; add crate to carrier  and set vehicle as being free
                    (at end (has ?carrier ?crate))
                    (at end (free ?veh))
            )
   )

;; CARRIER interactions
   (:durative-action unload_crate
            :parameters (?veh - vehicle
                        ?crate - crate
                        ?location - location
                        ?carrier - carrier
                        ?currentLoad - num
                        ?nextLoad    - num)
            :duration (= ?duration 5)
            :condition (and
                          ;location confirmation
                          (over all (at ?veh ?location))
                          (over all (at ?carrier ?location))

                          ;vehicle can carry crate
                          (at start (free ?veh))

                          ;carrier has crate loaded on it
                          (at start (has ?carrier ?crate))

                          ;carrier load confirmation (updated at the end)
                          (at end (has ?carrier ?currentLoad))

                          ;"currentLoad" should be next number of "nextLoad"
                          (over all (next ?nextLoad ?currentLoad))
            )
            :effect (and
                    ; set vehicle as not free and remove crate from carrier
                    (at start (not (has ?carrier ?crate)))
                    (at start (not (free ?veh)))

                    ;give the crate to the veh
                    (at end (has ?veh ?crate))

                    ;change the load of the carrier
                    (at end (not (has ?carrier ?currentLoad)))
                    (at end (has ?carrier ?nextLoad))
            )
    )
)
