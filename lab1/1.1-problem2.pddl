(define (problem emergency_prob2)
        (:domain WORLD)
        (:objects
                ;; locations
                loc1 loc2 loc3 loc4
                ;; crates
                med_crate1 med_crate2 food_crate1 
                ;; persons
                p1 p2
                ;; helicopters
                hel1
        )

        (:init
                (crate med_crate1)
                (crate med_crate2)
                (crate food_crate1)
                (location loc1)
                (location loc2)
                (location loc3)
                (location loc4)
                (person p1)
                (person p2)
                (helicopter hel1)
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
               (has medicine p1)
               (has medicine p2)
               (has food p1)
               (has food p2)
        )
	)
)
