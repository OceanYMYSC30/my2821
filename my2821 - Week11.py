#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr  7 21:36:11 2024

@author: ocean
"""

def WhoAmI():
    return('my2821')

def getBondPrice(y, face, couponRate, m, ppy=1):
    coupon = face * couponRate/ppy
    bondPrice = 0
    for i in range(1, m*ppy+1):
        bondPrice += coupon * (1+y/ppy)**-i
    bondPrice += face * (1+y/ppy)**-(m*ppy)
    return(bondPrice)

def getBondDuration(y, face, couponRate, m, ppy = 1):
    bondPrice = getBondPrice(y, face, couponRate, m, ppy)
    coupon = face * couponRate/ppy
    w = 0
    for i in range(1, m*ppy+1):
        w += coupon * ((1+y/ppy)**-i) * i
    w += face * (1+y/ppy)**-(m*ppy) * (m*ppy)
    bondDuration = w/bondPrice
    return(bondDuration)

def getBondPrice_E(face, couponRate, yc):
    '<Your work using enumerate>'
    coupon = face * couponRate
    bondPrice = 0
    for year, ytm in enumerate(yc, start=1):
        bondPrice += coupon * (1+ytm)**-year
    bondPrice += face * ((1+yc[-1])**-len(yc))
    return(bondPrice)

def getBondPrice_Z(face, couponRate, times, yc):
    '<Your work using zip>'
    coupon = face * couponRate
    bondPrice = 0
    for year, ytm in zip(times, yc):
        bondPrice += coupon * (1+ytm)**-year
    bondPrice += face * ((1+yc[-1]))**-(times[-1])
    return(bondPrice)

def FizzBuzz(start, finish):
    outlist = []
    for i in range(start, finish+1):
        if i % 3 == 0 and i % 5 ==0:
            outlist.append('fizzbuzz')
        elif i % 3 == 0:
            outlist.append('fizz')
        elif i % 5 ==0:
            outlist.append('buzz')
        else:
            outlist.append(i)
    return(outlist)



