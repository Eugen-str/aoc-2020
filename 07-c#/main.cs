using System;
using System.IO;
using System.Collections.Generic;
using System.Text.RegularExpressions;

class Child{
    public string color;
    public int amount;
    
    public Child(string color, int amount){
        this.color = color;
        this.amount = amount;
    }
}

class Rule{
    public string color;
    public List<Child> children;

    public Rule(string color, List<Child> children){
        this.color = color;
        this.children = children;
    }
}

class Program
{
    static Rule rule_from_line(string line){
        string[] parts = line.Split("contain");
        string rule_color = parts[0].Replace("bags", "").Trim();
        
        List<Child> c = new List<Child>();

        if(parts[1] == "no other bags."){
            return new Rule(rule_color, c);
        }

        foreach(string a in parts[1].Split(',')){
            string color = "";
            int amount = 0;

            Match m = Regex.Match(a, @" ([0-9]+) (.*) bags?");
            if(m.Success){
                amount = int.Parse(m.Groups[1].Value);
                color = m.Groups[2].Value;
            }
            c.Add(new Child(color.Trim(), amount));
        }
        return new Rule(rule_color, c);
    }

    static Dictionary<string, Rule> dict_of_rules(List<Rule> rules){
        Dictionary<string, Rule> d = new Dictionary<string, Rule>();

        foreach(Rule rule in rules){
            d.Add(rule.color, rule);
        }
        return d;
    }
    
    static int traverse(Rule rule, Dictionary<string, Rule> dict){        
        foreach(Child c in rule.children){
            if(c.color == "shiny gold"){
                return 1;
            }
            if(!String.IsNullOrEmpty(c.color)){
                if (traverse(dict[c.color], dict) == 1){
                    return 1;
                }
            }
        }

        return 0;
    }

    static int solution1(List<Rule> rules){
        int result = 0;
        Dictionary<string, Rule> dict = dict_of_rules(rules);

        foreach(Rule rule in rules){
            result += traverse(rule, dict);
        }

        return result;
    }

    static void Main(string[] args){
        List<Rule> rules = new List<Rule>(); 
        
        try{
            StreamReader sr = new StreamReader("input.txt");

            string line = sr.ReadLine();
            while(line != null){
                rules.Add(rule_from_line(line));
                line = sr.ReadLine();
            }
        }
        catch{
            Console.WriteLine("Error loading file.");
        }
        
        Console.WriteLine("\nSolution 1 : " + solution1(rules));
    }
}
