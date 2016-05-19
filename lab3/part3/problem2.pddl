(define (problem emergency_prob2)
        (:domain WORLD)
        (:objects
                ; define all constants (the planners does not allow
                ; constant declarations in domain T________T )
                num0 num1 num2 num3 num4 - num
                depot - location

                 ;defining all crate content types
                food - content
                medicine - content

                ;; locations
                loc1 loc2 loc3 loc4 - location
                ;; crates
                med_crate1 med_crate2 food_crate1 - crate 
                ;; persons
                p1 p2 - person
                ;; uavs
                uav1 uav2 uav3 uav4 - uav

                ;; carriers
                car1 car2 - carrier
        )

        (:init
                (next num0 num1)
                (next num1 num2)
                (next num2 num3)
                (next num3 num4)
                (free uav1)
                (free uav2)
                (free uav3)
                (free uav4)

                (at med_crate1 depot)
                (at med_crate2 depot)
                (at food_crate1 depot)
                (at uav1 depot)
                (at uav2 depot)
                (at uav3 depot)
                (at uav4 depot)

                (has med_crate1 medicine)
                (has med_crate2 medicine)
                (has food_crate1 food)

                (at car1 depot)
                (at car2 depot)
                (has car1 num0)
                (has car2 num0)
                
                (at p1 loc4)
                (at p2 loc3)
        )

        (:goal (and
               (has p1 medicine)
               (has p2 medicine)
               (has p2 food)
               )
        )
)
