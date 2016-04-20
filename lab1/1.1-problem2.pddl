(define (problem emergency_prob2)
        (:domain WORLD)
        (:objects
                ;; locations
                loc1 loc2 loc3 loc4 - location
                ;; crates
                med_crate1 med_crate2 food_crate1 - crate 
                ;; persons
                p1 p2 - person
                ;; helicopters
                hel1 - helicopter
        )

        (:init
		(free hel1)

                (at med_crate1 depot)
                (at med_crate2 depot)
                (at food_crate1 depot)
                (at hel1 depot)

		(has med_crate1 medicine)
		(has med_crate2 medicine)
		(has food_crate1 food)
                
                (at p1 loc4)
                (at p2 loc3)
                (has p1 food)
                 
        )

        (:goal (and
               (has p1 medicine)
               (has p2 medicine)
               (has p1 food)
               (has p2 food)
        )
	)
)
