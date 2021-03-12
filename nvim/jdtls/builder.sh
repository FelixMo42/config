export PATH="$coreutils/bin:$jdk11/bin:$maven/bin"
export JAVA_HOME=$jdk11

cd $src

./gradlew build
