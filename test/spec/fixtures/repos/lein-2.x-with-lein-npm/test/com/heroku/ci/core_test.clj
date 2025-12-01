(ns com.heroku.ci.core-test
  (:require [clojure.test :refer :all]
            [com.heroku.ci.core :refer :all]))

(deftest addition-test
  (testing "Basic arithmetic"
    (is (= 4 (+ 2 2)))))

(deftest subtraction-test
  (testing "Subtraction works"
    (is (= 0 (- 2 2)))))
