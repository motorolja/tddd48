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
                uav1 - uav

                ;; carriers
                car1 - carrier
        )

        (:init
                (= (total-cost) 0)
                (next num0 num1)
                (next num1 num2)
                (next num2 num3)
                (next num3 num4)
                (free uav1)

                (at med_crate1 depot)
                (at med_crate2 depot)
                (at food_crate1 depot)
                (at uav1 depot)

                (has med_crate1 medicine)
                (has med_crate2 medicine)
                (has food_crate1 food)

                (at car1 depot)
                (has car1 num0)
                
                (at p1 loc4)
                (at p2 loc3)
                 
                (= (fly-cost depot depot) 0)
                (= (fly-cost loc1 loc1) 0)
                (= (fly-cost loc2 loc2) 0)
                (= (fly-cost loc3 loc3) 0)
                (= (fly-cost loc4 loc4) 0)


                (= (fly-cost depot loc1) 25)
                (= (fly-cost depot loc2) 25)
                (= (fly-cost depot loc3) 25)
                (= (fly-cost depot loc4) 25)
                (= (fly-cost loc1 depot) 25)
                (= (fly-cost loc2 depot) 25)
                (= (fly-cost loc3 depot) 25)
                (= (fly-cost loc4 depot) 25)

                (= (fly-cost loc1 loc2) 10)
                (= (fly-cost loc1 loc3) 10)
                (= (fly-cost loc1 loc4) 10)
                (= (fly-cost loc2 loc1) 10)
                (= (fly-cost loc2 loc3) 10)
                (= (fly-cost loc2 loc4) 10)
                (= (fly-cost loc3 loc1) 10)
                (= (fly-cost loc3 loc2) 10)
                (= (fly-cost loc3 loc4) 10)
                (= (fly-cost loc4 loc1) 10)
                (= (fly-cost loc4 loc2) 10)
                (= (fly-cost loc4 loc3) 10)
        )

        (:goal (and
               (has p1 medicine)
               (has p2 medicine)
               (has p2 food)
               )
        )
)
