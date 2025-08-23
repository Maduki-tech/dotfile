#!/bin/bash

# get parameters

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

$1 = project name

# init maven project
mvn archetype:generate -DgroupId=de.schlueter -DartifactId=$1 -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

cd $1

# create Run
cat > run << EOF
#!/bin/bash
mvn clean compile -q
mvn exec:java -Dexec.mainClass="de.schlueter.App" -q
EOF
chmod +x run


echo "remember to add the following to your pom.xml"
echo "<build>"
echo "  <plugins>"
echo "    <plugin>"
echo "      <groupId>org.codehaus.mojo</groupId>"
echo "      <artifactId>exec-maven-plugin</artifactId>"
echo "      <version>1.6.0</version>"
echo "      <configuration>"
echo "        <mainClass>de.schlueter.App</mainClass>"
echo "      </configuration>"
echo "    </plugin>"
echo "  </plugins>"
echo "</build>"
echo ""
echo "run with ./run"


# create .clang-format
cat > .clang-format << EOF
BasedOnStyle: Google
IndentWidth: 4
ContinuationIndentWidth: 4
ColumnLimit: 100
AccessModifierOffset: -4
AlignAfterOpenBracket: Align
AlignConsecutiveAssignments: false
AlignConsecutiveDeclarations: false
AlignEscapedNewlines: Left
AlignOperands: true
AlignTrailingComments: true
AllowAllParametersOfDeclarationOnNextLine: true
AllowShortBlocksOnASingleLine: false
AllowShortCaseLabelsOnASingleLine: false
AllowShortFunctionsOnASingleLine: None
AllowShortIfStatementsOnASingleLine: false
AllowShortLoopsOnASingleLine: false
AlwaysBreakAfterDefinitionReturnType: None
AlwaysBreakAfterReturnType: None
AlwaysBreakBeforeMultilineStrings: false
BreakBeforeBraces: Attach
BreakBeforeTernaryOperators: true
BreakConstructorInitializersBeforeComma: false
KeepEmptyLinesAtTheStartOfBlocks: false
MaxEmptyLinesToKeep: 1
NamespaceIndentation: None
PointerAlignment: Left
SpaceAfterCStyleCast: false
SpaceBeforeAssignmentOperators: true
SpaceBeforeParens: ControlStatements
SpaceInEmptyParentheses: false
SpacesInAngles: false
SpacesInContainerLiterals: true
SpacesInCStyleCastParentheses: false
SpacesInParentheses: false
SpacesInSquareBrackets: false
Standard: Cpp11
TabWidth: 4
UseTab: Never
EOF



