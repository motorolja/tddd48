(define (problem emergency_prob1)
        (:domain WORLD)
        (:objects
                ; define all constants (the planners does not allow
                ; constant declarations in domain T________T )
                num0 num1 num2 num3 num4 - num
                depot - location

                 ;defining all crate content types
                food - content
                medicine - content
                carrier1 - carrier
                ;; locations
                loc1 - location
                ;; crates
                med_crate1 - crate
                food_crate1 - crate
                ;; persons
                p1 - person
                ;; uavs
                uav1 - uav
                rob1 - robot
        )

        (:init
                (next num0 num1)
                (next num1 num2)
                (next num2 num3)
                (next num3 num4)
                (free uav1)
                (free rob1)
                (has med_crate1 medicine)
                (has food_crate1 food)
                (at med_crate1 depot)
                (at food_crate1 depot)
                (at uav1 depot)
                (at rob1 depot)
                (at carrier1 depot)
                (has carrier1 num0)
                (at p1 loc1)
        )

        (:goal (and
               (has p1 medicine)
               (has p1 food)
        )

    )
)
