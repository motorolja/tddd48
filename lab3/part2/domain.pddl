(define (domain simplerover2)
    (:requirements :typing :durative-actions)
    (:types rover location data - object)
    (:predicates
        (at ?rover - rover ?location - location)
        (acquired ?rover - rover ?d - data)
        (available ?r - rover)
        (sent ?d - data)
        (path-between ?a ?u - location)
    )
    
    (:durative-action drive
        :parameters (?r - rover ?from ?to - location)
        :duration (= ?duration 10)
        :condition (and (at start (at ?r ?from))
                        (over all (path-between ?from ?to)))
        :effect (and 
                   (at start (not (at ?r ?from)))
                   (at end (at ?r ?to))))

    (:durative-action send
        :parameters (?r - rover ?d - data ?loc - location)
        :duration (= ?duration 2)
        :condition (and 
                     (at start (available ?r))
                     (over all (acquired ?r ?d))
                     (over all (at ?r ?loc)))
        :effect ( and
                    (at start (not (available ?r)))
                    (at end (sent ?d))
                    (at end (available ?r))
                )
    )
)
